#
# Copyright 2012-2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name 'libtool'
default_version '2.4'

license 'GPL-2.0'
license_file 'COPYING'

dependency 'config_guess'

# NOTE: 2.4.6 2.4.2 do not compile on solaris2 yet
version('2.4') { source md5: 'b32b04148ecdd7344abc6fe8bd1bb021' }

source url: "https://ftp.gnu.org/gnu/libtool/libtool-#{version}.tar.gz"

relative_path "libtool-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess
  update_config_guess(target: 'libltdl/config')

  env['M4'] = '/opt/freeware/bin/m4' if aix?

  command './configure' \
          " --prefix=#{install_dir}/embedded", env: env

  make env: env
  make 'install', env: env
end
