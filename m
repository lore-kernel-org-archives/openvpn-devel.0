From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Fwd: Bug#182020: openvpn needs dynamic choice
 on HAVE_LINUX_IF_TUN_H
In-Reply-To: <20030508090415.GE2698@...30...>
Message-ID: <Pine.LNX.4.44.0305081303390.23013-200000@...41...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-781915450-1052421137=:23013"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu May  8 12:14:10 2003
To: Alberto Gonzalez Iniesta <agi@...5...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@...24... for more info.

--655616-781915450-1052421137=:23013
Content-Type: TEXT/PLAIN; charset=US-ASCII

Alberto,

Here is a patch against 1.4.0 that tries the 2.4 TUN/TAP interface then 
falls back to 2.2 if it fails.  I don't have access to a 2.2 machine so I 
have not been able to test.  Let me know if it works.

James

On Thu, 8 May 2003, Alberto Gonzalez Iniesta wrote:

> On Thu, May 08, 2003 at 08:30:34AM -0000, James Yonan wrote:
> > Alberto Gonzalez Iniesta <agi@...5...> said:
> > 
> > > When compiled with 2.4.* kernel headers (libc6-dev 2.2.5-14.3 headers)
> > > it detects this header file and defines HAVE_LINUX_IF_TUN_H. This allow
> > > openvpn to work correctly with 2.4.18 kernels BUT it stops it working
> > > with 2.2.X kernels at all (with or without the tun kernel module from
> > > sourceforge)
> > 
> > OpenVPN's config script assumes that if 2.4 headers are present (i.e.
> > if_tun.h), then it should build for the 2.4 tun/tap driver.
> > 
> > I don't completely understand why one would want to put 2.4 kernel headers on
> > a 2.2 machine, since that would tend to confuse things, and break apps that
> > depend on the userspace <-> kernel interface as defined by the kernel header
> > files.
> 
> The problem (again) is distributing binaries. I compile Debian's
> packages in my 2.4.x box, but those packages may be used in 2.2 boxes.
> I could find a 2.2 box (could I?) to compile them, but then the problem
> would be the other way around, wouldn't it?
> 
> So, and as the bug reported says, we have two choices:
> 
> a) I make two binaries in the package, and choose at installation time
> which one should be used. (will uname -r do? I guess so)
> b) openvpn detects at run time which tun interface to use.
> 
> pros? cons?
> 
> Regards,
> 
> Alberto
> 
> 
> > But in any case, you can still build if you do the following.
> > 
> > (1) run ./configure
> > (2) edit config.h
> > (3) comment out this line: #define HAVE_LINUX_IF_TUN_H 1
> > (4) run make
> > 
> > This could be automatic if ./configure did a kernel version test, and only
> > defined HAVE_LINUX_IF_TUN_H if (a) if_tun.h exists and (b) kernel version is
> > 2.4.x.
> > 
> > James
> > 
> > > Options are:
> > > 
> > > 1) Seperate compiles for 2.2.X and 2.4+ kernels, both binaries in the .deb
> > > 
> > > 2) Patch tun.c to first check if /dev/net/tun exists and works before
> > >    falling back to the open_tun_generic(..) function if it doesn't.

Here is a patch against 1.4.0 that does this (attached).  I don't have 
access to a 2.2 machine so I have not been able to test.

> > > 
> > > I'm currently successfully using openvpn between a 2.2.19 and 2.4.18
> > > kernel using the tun0 tunnel and the driver from sourceforge on the 2.2.19
> > > machine. (No reboot required to install the tun0 driver) The 2.4.18
> > > openvpn is standard, the 2.2.19 has HAVE_LINUX_IF_TUN_H undefined.
> > > 
> > > Both machines are woody with libc6/testing.
> > > 
> 
> 
> 

--655616-781915450-1052421137=:23013
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux_2_2_fallback.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0305081312170.23013@...41...>
Content-Description: 
Content-Disposition: attachment; filename="linux_2_2_fallback.patch"

LS0tIG9wZW52cG4tMS40LjAvdHVuLmMJU2F0IE1heSAgMyAwNDo1NzowNyAy
MDAzDQorKysgb3BlbnZwbi1uZXcvdHVuLmMJVGh1IE1heSAgOCAxMjo1NDow
MiAyMDAzDQpAQCAtMzc1LDEwICszNzUsMTQgQEANCiAgICAgfQ0KICAgZWxz
ZQ0KICAgICB7DQotICAgICAgaWYgKCFkZXZfbm9kZSkNCi0JZGV2X25vZGUg
PSAiL2Rldi9uZXQvdHVuIjsNCi0gICAgICBpZiAoKHR0LT5mZCA9IG9wZW4g
KGRldl9ub2RlLCBPX1JEV1IpKSA8IDApDQotCW1zZyAoTV9FUlIsICJDYW5u
b3Qgb3BlbiBUVU4vVEFQIGRldiAlcyIsIGRldl9ub2RlKTsNCisgICAgICBj
b25zdCBjaGFyICpub2RlID0gZGV2X25vZGU7DQorICAgICAgaWYgKCFub2Rl
KQ0KKwlub2RlID0gIi9kZXYvbmV0L3R1biI7DQorICAgICAgaWYgKCh0dC0+
ZmQgPSBvcGVuIChub2RlLCBPX1JEV1IpKSA8IDApDQorCXsNCisJICBtc2cg
KE1fV0FSTiB8IE1fRVJSTk8sICJOb3RlOiBDYW5ub3Qgb3BlbiBUVU4vVEFQ
IGRldiAlcyIsIG5vZGUpOw0KKwkgIGdvdG8gbGludXhfMl8yX2ZhbGxiYWNr
Ow0KKwl9DQogDQogICAgICAgQ0xFQVIgKGlmcik7DQogICAgICAgaWYgKCF0
dC0+aXB2NikNCkBAIC00MDEsNyArNDA1LDEwIEBADQogCXN0cm5jcHludCAo
aWZyLmlmcl9uYW1lLCBkZXYsIElGTkFNU0laKTsNCiANCiAgICAgICBpZiAo
aW9jdGwgKHR0LT5mZCwgVFVOU0VUSUZGLCAodm9pZCAqKSAmaWZyKSA8IDAp
DQotCW1zZyAoTV9XQVJOLCAiQ2Fubm90IGlvY3RsIFRVTlNFVElGRiAlcyIs
IGRldik7DQorCXsNCisJICBtc2cgKE1fV0FSTiB8IE1fRVJSTk8sICJOb3Rl
OiBDYW5ub3QgaW9jdGwgVFVOU0VUSUZGICVzIiwgZGV2KTsNCisJICBnb3Rv
IGxpbnV4XzJfMl9mYWxsYmFjazsNCisJfQ0KIA0KICAgICAgIHNldF9ub25i
bG9jayAodHQtPmZkKTsNCiAgICAgICBzZXRfY2xvZXhlYyAodHQtPmZkKTsN
CkBAIC00MzMsNiArNDQwLDEyIEBADQogCSAgICB9DQogCX0NCiAgICAgfQ0K
KyAgcmV0dXJuOw0KKw0KKyBsaW51eF8yXzJfZmFsbGJhY2s6DQorICBtc2cg
KE1fSU5GTywgIk5vdGU6IEF0dGVtcHRpbmcgZmFsbGJhY2sgdG8ga2VybmVs
IDIuMiBUVU4vVEFQIGludGVyZmFjZSIpOw0KKyAgY2xvc2VfdHVuX2dlbmVy
aWMgKHR0KTsNCisgIG9wZW5fdHVuX2dlbmVyaWMgKGRldiwgZGV2X25vZGUs
IGRldl9uYW1lLCBpcHY2LCBmYWxzZSwgdHJ1ZSwgdHQpOw0KIH0NCiANCiAj
ZWxzZQ0K
--655616-781915450-1052421137=:23013--

