References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <ca4da521-e34e-3113-6dfe-bf1a33a19b90@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <6126e9fd-4858-65d5-8c88-e9ea9d4ddde0@...515...>
Date: Sun, 30 Dec 2018 16:56:48 +0200
MIME-Version: 1.0
In-Reply-To: <ca4da521-e34e-3113-6dfe-bf1a33a19b90@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

Il 29/12/18 22:06, tincanteksup ha scritto:
> 
> 
> On 28/12/2018 14:21, tincanteksup wrote:
>> Hi,
>>
>> On 27/12/2018 18:11, Samuli Seppänen wrote:
>>>
> 
>>> Also, if you can, please review these PRs which enable anyone to build
>>> the Ubuntu/Debian packages, including ones for Ubuntu 18.04:
>>>
>>> https://github.com/OpenVPN/sbuild_wrapper/pull/1
>>> https://github.com/OpenVPN/openvpn-vagrant/pull/6
>>>
>>
>> Working on it ..
>>
> 
> Tested and working but with one note.
> 
> scripts/prepare-all.sh
> ```
> dpkg-buildpackage -d -S -uc -us
> ```
> does not work.
> 
> The failure is:
> ```
> tct@...2045...:~/openvpn/pkg-bsys$ sudo scripts/prepare-all.sh
> --2018-12-29 16:04:53--
> http://build.openvpn.net/downloads/releases/openvpn-2.4.6.tar.gz
> Resolving build.openvpn.net (build.openvpn.net)... 52.52.118.245,
> 2600:1f1c:702:ae00:f27c:d805:3b80:a45d
> Connecting to build.openvpn.net (build.openvpn.net)|52.52.118.245|:80...
> connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 1431971 (1.4M) [application/octet-stream]
> Saving to: ‘openvpn-2.4.6.tar.gz’
> 
> openvpn-2.4.6.tar.gz
> 100%[========================================================================>]
>   1.37M   159KB/s    in 7.4s
> 
> 2018-12-29 16:05:00 (190 KB/s) - ‘openvpn-2.4.6.tar.gz’ saved
> [1431971/1431971]
> 
> cp: 'debian/patches/series' and 'debian/patches/series' are the same file
> dpkg-buildpackage: info: source package openvpn
> dpkg-buildpackage: info: source version 2.4.6-bionic0
> dpkg-buildpackage: info: source distribution stable
> dpkg-buildpackage: info: source changed by Samuli Seppänen
> <samuli@...515...>
>  dpkg-source --before-build openvpn-2.4.6
> dpkg-source: info: applying move_log_dir.patch
> dpkg-source: info: applying auth-pam_libpam_so_filename.patch
> dpkg-source: info: applying debian_nogroup_for_sample_files.patch
> dpkg-source: info: applying openvpn-pkcs11warn.patch
> dpkg-source: info: applying kfreebsd_support.patch
> dpkg-source: info: applying match-manpage-and-command-help.patch
>  debian/rules clean
> dh clean
> make: dh: Command not found

Package "debhelper" is missing. When using Vagrant debhelper gets
installed in the provisioning script:

  https://github.com/mattock/openvpn-vagrant/blob/sbuild/sbuild.sh

That provisioning script should run fine on any Ubuntu 18.04 VM, not
just inside Vagrant/Virtualbox.

> debian/rules:16: recipe for target 'clean' failed
> make: *** [clean] Error 127
> dpkg-buildpackage: error: debian/rules clean subprocess returned exit
> status 2
> 
> ```
> 
> Change scripts/prepare-all.sh
> ```
> dpkg-buildpackage -nc -d -S -uc -us
> ```
> Works, tested on two independent systems.
> 
> The output is now:
> ```
> tct@...2045...:~/openvpn/pkg-bsys$ sudo scripts/prepare-all.sh
> --2018-12-29 19:25:52--
> http://build.openvpn.net/downloads/releases/openvpn-2.4.6.tar.gz
> Resolving build.openvpn.net (build.openvpn.net)... 52.52.118.245,
> 2600:1f1c:702:ae00:f27c:d805:3b80:a45d
> Connecting to build.openvpn.net (build.openvpn.net)|52.52.118.245|:80...
> connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 1431971 (1.4M) [application/octet-stream]
> Saving to: ‘openvpn-2.4.6.tar.gz’
> 
> openvpn-2.4.6.tar.gz
> 100%[========================================================================>]
>   1.37M   308KB/s    in 5.0s
> 
> 2018-12-29 19:25:57 (282 KB/s) - ‘openvpn-2.4.6.tar.gz’ saved
> [1431971/1431971]
> 
> cp: 'debian/patches/series' and 'debian/patches/series' are the same file
> dpkg-buildpackage: info: source package openvpn
> dpkg-buildpackage: info: source version 2.4.6-bionic0
> dpkg-buildpackage: info: source distribution stable
> dpkg-buildpackage: info: source changed by Samuli Seppänen
> <samuli@...515...>
>  dpkg-source --before-build openvpn-2.4.6
> dpkg-source: info: applying move_log_dir.patch
> dpkg-source: info: applying auth-pam_libpam_so_filename.patch
> dpkg-source: info: applying debian_nogroup_for_sample_files.patch
> dpkg-source: info: applying openvpn-pkcs11warn.patch
> dpkg-source: info: applying kfreebsd_support.patch
> dpkg-source: info: applying match-manpage-and-command-help.patch
> dpkg-buildpackage: warning: building a source package without cleaning
> up as you asked; it might contain undesired files
>  dpkg-source -b openvpn-2.4.6
> dpkg-source: info: using source format '3.0 (quilt)'
> dpkg-source: info: building openvpn using existing
> ./openvpn_2.4.6.orig.tar.gz
> dpkg-source: info: building openvpn in openvpn_2.4.6-bionic0.debian.tar.xz
> dpkg-source: info: building openvpn in openvpn_2.4.6-bionic0.dsc
>  dpkg-genbuildinfo --build=source
>  dpkg-genchanges --build=source >../openvpn_2.4.6-bionic0_source.changes
> dpkg-genchanges: info: including full source code in upload
>  dpkg-source --after-build openvpn-2.4.6
> dpkg-source: info: unapplying match-manpage-and-command-help.patch
> dpkg-source: info: unapplying kfreebsd_support.patch
> dpkg-source: info: unapplying openvpn-pkcs11warn.patch
> dpkg-source: info: unapplying debian_nogroup_for_sample_files.patch
> dpkg-source: info: unapplying auth-pam_libpam_so_filename.patch
> dpkg-source: info: unapplying move_log_dir.patch
> dpkg-buildpackage: info: full upload (original source is included)
> 
> ```
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


