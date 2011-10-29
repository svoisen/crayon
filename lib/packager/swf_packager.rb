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

require 'packager/substitutor'

module Crayon
  module Packager

    class SWFPackager
      def package(input, output, mxmlc, keep_temp, width, height, framerate)

        # Replace width, height, framerate in compiled file
        compiled = IO.read(input)
        Substitutor.substitute!( compiled, {'width' => width.to_s, 'height' => height.to_s, 'framerate' => framerate.to_s} )
        File.open(input, 'w') {|f| f.write compiled}

        `#{mxmlc} -library-path+=#{File.expand_path(File.dirname(__FILE__))}/../as3/bin #{input} -o #{output}.swf -debug=true -static-link-runtime-shared-libraries=true`

        unless keep_temp
          File.delete input
        end
      end
    end

  end
end
