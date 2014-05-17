# Copyright (c) 2010-2011 Sean Voisen.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'fileutils'
require 'packager/substitutor'

module Crayon
  module Packager

    class HTMLPackager

      def package(compiled_file, output_dir, template_name, program_name, width, height, framerate)
        # Update framerate in compiled file
        compiled = IO.read(compiled_file)
        Substitutor.substitute!( compiled, {'framerate' => framerate.to_s} )
        File.open(compiled_file, 'w') {|f| f.write compiled}

        create_package_dir(compiled_file, output_dir, template_name)
        complete_template(output_dir + "/#{template_name}.html", program_name, width, height)
      end

      private

        def create_package_dir(compiled_file, output_dir, template_name)
          begin
            Dir.mkdir(output_dir)
            FileUtils.cp_r(File.dirname(__FILE__) + "/../js/src/crayon", output_dir)
            FileUtils.cp_r(File.dirname(__FILE__) + "/../js/src/easeljs", output_dir)
            FileUtils.cp(File.dirname(__FILE__) + "/template/html/#{template_name}.html", output_dir)
            FileUtils.mv(compiled_file, output_dir)
          rescue SystemCallError => e
            $stderr.puts e
            exit 0
          end
        end

        def complete_template(template_path, title, width, height)
          template = IO.read(template_path)
          Substitutor.substitute!( template, {'title' => title, 'compiled' => "#{title}.js", 'width' => width.to_s, 'height' => height.to_s} )
          File.open(template_path, 'w') {|f| f.write template}
        end
    end

  end
end
