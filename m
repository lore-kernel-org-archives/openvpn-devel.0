From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Assertion failed at multi.c:1561
In-Reply-To: <Pine.LNX.4.58.0510271336200.8183@...41...>
Message-ID: <Pine.LNX.4.58.0510271702160.8183@...41...>
References: <djp9ut$8k5$1@...165...> <Pine.LNX.4.58.0510271336200.8183@...41...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-671803466-1130455054=:8183"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Oct 27 16:19:49 2005
To: Gunter Ohrner <G.Ohrner@...484...>
Cc: openvpn-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@...24... for more info.

--8323328-671803466-1130455054=:8183
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 27 Oct 2005, James Yonan wrote:

> On Thu, 27 Oct 2005, Gunter Ohrner wrote:
> 
> > Hi!
> > 
> > We're experiencing regular assertion failures and subsequent OpenVPN server
> > crashes on one of our servers.
> > 
> > The assertion failure is always the same: 
> > 
> > ,----
> > | Assertion failed at multi.c:1561
> > | Exiting
> > `----
> > 
> > The crash seems to leave openvpn's network device, tap0 in our case, in a
> > state which blocks all processes subsequently trying to access to device.
> > The crashes happen every few days and a restart of the server machine is
> > needed.
> > 
> > Does anyone have any quick idea of this behaviour's cause? Unfortunately
> > according to Google we're the only ones on Linux 2.6 with this crash. ;)
> > 
> > http://openvpn.net/archive/openvpn-users/2005-08/msg00011.html mentions a
> > similar problem but running kernel 2.2.25 and no solution has been provided
> > so far, a suggested patch did not fix the problem for the reporter.
> > 
> > ,----[ Some details about our setup ]
> > | * Debian Sarge i386
> > | * Kernel 2.6.12.6 32 Bit Opteron optimized
> > | * Debian's 2.0-1sarge1 openvpn package
> > | * Dual Opteron 246 2,0GHz
> > `----
> > 
> > ,----[ OpenVPN configuration (excerpts) ]
> > | * bind to single interface/port
> > | * use udp
> > | * use tap0
> > | * PSK authentication
> > `----
> > 
> > The server is also routing traffic and we do traffic limiting for some
> > traffic (destination dependant, to comply with a leased link policy). This
> > limiting is not done on the device on which the encrypted openvpn traffic
> > leaves the machine but on an IMQ device before the incoming traffic enters
> > tap0, so openvpn should not see anything from it.
> > 
> > Are there any further details needed to chase this bug, in whichever kind of 
> > software we're using it may be?
> 
> This assertion usually occurs when the tun/tap device locks up and doesn't 
> accept any write syscalls.
> 
> Can you try an earlier 2.6 kernel (or 2.4), and see if the problem goes
> away?
> 
> I would lean towards thinking that this is a tun/tap driver issue, simply 
> because I've never heard about it on anything other than the old 
> unmaintained 2.2 driver, or in this case a very new kernel.
> 
> But having said that, I can't yet rule out that it's an OpenVPN bug.  I 
> could certainly "fix" the assertion by making OpenVPN wait forever for the 
> tun/tap device to accept output.  But then OpenVPN would simply hang, and 
> you would have even less information to go on.

Ok, here's an update.  I'm attaching a patch which I believe will fix 
this.  I've only been able to reproduce the assertion under simulated 
conditions, therefore it would be great if you could test in a real-world 
setting.

The patch should apply cleanly to 2.0, 2.0.x, or 2.1-beta.

James

--8323328-671803466-1130455054=:8183
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="multi1586.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0510271717340.8183@...41...>
Content-Description: 
Content-Disposition: attachment; filename="multi1586.patch"

SW5kZXg6IG11bHRpLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBt
dWx0aS5jCShyZXZpc2lvbiA2NzIpDQorKysgbXVsdGkuYwkocmV2aXNpb24g
NzMwKQ0KQEAgLTE1ODMsNyArMTU4Myw4IEBADQogICBzdHJ1Y3QgbXVsdGlf
aW5zdGFuY2UgKm1pOw0KICAgYm9vbCByZXQgPSB0cnVlOw0KIA0KLSAgQVNT
RVJUICghbS0+cGVuZGluZyk7DQorICBpZiAobS0+cGVuZGluZykNCisgICAg
cmV0dXJuIHRydWU7DQogDQogICBpZiAoIWluc3RhbmNlKQ0KICAgICB7DQpA
QCAtMTczNyw3ICsxNzM4LDggQEANCiAgICAgICBwcmludGYgKCJUVU4gLT4g
VENQL1VEUCBbJWRdXG4iLCBCTEVOICgmbS0+dG9wLmMyLmJ1ZikpOw0KICNl
bmRpZg0KIA0KLSAgICAgIEFTU0VSVCAoIW0tPnBlbmRpbmcpOw0KKyAgICAg
IGlmIChtLT5wZW5kaW5nKQ0KKwlyZXR1cm4gdHJ1ZTsNCiANCiAgICAgICAv
KiANCiAgICAgICAgKiBSb3V0ZSBhbiBpbmNvbWluZyB0dW4vdGFwIHBhY2tl
dCB0bw0KSW5kZXg6IGZvcndhcmQuYw0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KLS0tIGZvcndhcmQuYwkocmV2aXNpb24gNjcyKQ0KKysrIGZvcndhcmQu
YwkocmV2aXNpb24gNzMwKQ0KQEAgLTYwOSwxMCArNjA5LDEwIEBADQogICAg
Ki8NCiAgIGludCBzdGF0dXM7DQogDQorICAvKkFTU0VSVCAoIWMtPmMyLnRv
X3R1bi5sZW4pOyovDQorDQogICBwZXJmX3B1c2ggKFBFUkZfUkVBRF9JTl9M
SU5LKTsNCiANCi0gIEFTU0VSVCAoIWMtPmMyLnRvX3R1bi5sZW4pOw0KLQ0K
ICAgYy0+YzIuYnVmID0gYy0+YzIuYnVmZmVycy0+cmVhZF9saW5rX2J1ZjsN
CiAgIEFTU0VSVCAoYnVmX2luaXQgKCZjLT5jMi5idWYsIEZSQU1FX0hFQURS
T09NX0FESiAoJmMtPmMyLmZyYW1lLCBGUkFNRV9IRUFEUk9PTV9NQVJLRVJf
UkVBRF9MSU5LKSkpOw0KICAgc3RhdHVzID0gbGlua19zb2NrZXRfcmVhZCAo
Yy0+YzIubGlua19zb2NrZXQsICZjLT5jMi5idWYsIE1BWF9SV19TSVpFX0xJ
TksgKCZjLT5jMi5mcmFtZSksICZjLT5jMi5mcm9tKTsNCkBAIC04MjQsMTMg
KzgyNCwxMyBAQA0KIHZvaWQNCiByZWFkX2luY29taW5nX3R1biAoc3RydWN0
IGNvbnRleHQgKmMpDQogew0KLSAgcGVyZl9wdXNoIChQRVJGX1JFQURfSU5f
VFVOKTsNCi0NCiAgIC8qDQogICAgKiBTZXR1cCBmb3IgcmVhZCgpIGNhbGwg
b24gVFVOL1RBUCBkZXZpY2UuDQogICAgKi8NCi0gIEFTU0VSVCAoIWMtPmMy
LnRvX2xpbmsubGVuKTsNCisgIC8qQVNTRVJUICghYy0+YzIudG9fbGluay5s
ZW4pOyovDQogDQorICBwZXJmX3B1c2ggKFBFUkZfUkVBRF9JTl9UVU4pOw0K
Kw0KICAgYy0+YzIuYnVmID0gYy0+YzIuYnVmZmVycy0+cmVhZF90dW5fYnVm
Ow0KICNpZmRlZiBUVU5fUEFTU19CVUZGRVINCiAgIHJlYWRfdHVuX2J1ZmZl
cmVkIChjLT5jMS50dW50YXAsICZjLT5jMi5idWYsIE1BWF9SV19TSVpFX1RV
TiAoJmMtPmMyLmZyYW1lKSk7DQpAQCAtMTA1NiwxNCArMTA1NiwxNSBAQA0K
IHsNCiAgIHN0cnVjdCBnY19hcmVuYSBnYyA9IGdjX25ldyAoKTsNCiANCi0g
IHBlcmZfcHVzaCAoUEVSRl9QUk9DX09VVF9UVU4pOw0KLQ0KICAgLyoNCiAg
ICAqIFNldCB1cCBmb3Igd3JpdGUoKSBjYWxsIHRvIFRVTi9UQVANCiAgICAq
IGRldmljZS4NCiAgICAqLw0KLSAgQVNTRVJUIChjLT5jMi50b190dW4ubGVu
ID4gMCk7DQorICBpZiAoYy0+YzIudG9fdHVuLmxlbiA8PSAwKQ0KKyAgICBy
ZXR1cm47DQogDQorICBwZXJmX3B1c2ggKFBFUkZfUFJPQ19PVVRfVFVOKTsN
CisNCiAgIC8qDQogICAgKiBUaGUgLS1tc3NmaXggb3B0aW9uIHJlcXVpcmVz
DQogICAgKiB1cyB0byBleGFtaW5lIHRoZSBJUHY0IGhlYWRlci4NCg==

--8323328-671803466-1130455054=:8183--

