From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Management interface -- null-terminated lines
In-Reply-To: <pan.2004.12.01.04.17.16.247658@...294...>
Message-ID: <Pine.LNX.4.58.0411302304010.3572@...41...>
References: <pan.2004.12.01.04.17.16.247658@...294...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1819535020-1101881754=:3572"
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
Date: Tue Nov 30 22:16:01 2004
To: Charles Duffy <cduffy@...294...>
Cc: openvpn-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@...24... for more info.

--8323328-1819535020-1101881754=:3572
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 30 Nov 2004, Charles Duffy wrote:

> James,
> 
> I notice that the management interface terminates its lines \0d \0a \00.
> 
> Is the null termination intentional? If so, would you mind documenting it?
> It caused a few subtle issues until I figured out what was going on, so I
> wouldn't exactly mind if it went away.
> 
> (I'm working on a CLR-based library, and maybe when it works a Gtk#
> frontend, for interacting w/ OpenVPN via said interface).

Aha, good catch... the null termination is a bug, it should just be \0d 
\0a -- I will fix for beta19.

If you'd like an immediate fix, I've attached a patch.

James
--8323328-1819535020-1101881754=:3572
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="trailnullfix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0411302315540.3572@...41...>
Content-Description: 
Content-Disposition: attachment; filename="trailnullfix.patch"

LS0tIG9wZW52cG4tMi4wX2JldGExOC9idWZmZXIuYwkyMDA0LTExLTE3IDA0
OjEwOjQzLjAwMDAwMDAwMCAtMDYwMA0KKysrIC4vYnVmZmVyLmMJMjAwNC0x
MS0zMCAyMzo1MDoxNy41NjM4MjQ5NTIgLTA2MDANCkBAIC00NDEsMTEgKzQ0
MSwxOCBAQA0KICNlbmRpZg0KIHsNCiAgIHN0cnVjdCBidWZmZXIgYnVmOw0K
Kw0KKyAgQVNTRVJUIChzdHIpOw0KKw0KICNpZmRlZiBETUFMTE9DDQogICBi
dWZfc2V0X3JlYWQgKCZidWYsIHN0cmluZ19hbGxvY19kZWJ1ZyAoc3RyLCBO
VUxMLCBmaWxlLCBsaW5lKSwgc3RybGVuIChzdHIpICsgMSk7DQogI2Vsc2UN
CiAgIGJ1Zl9zZXRfcmVhZCAoJmJ1Ziwgc3RyaW5nX2FsbG9jIChzdHIsIE5V
TEwpLCBzdHJsZW4gKHN0cikgKyAxKTsNCiAjZW5kaWYNCisNCisgIGlmIChi
dWYubGVuID4gMCkgLyogRG9uJ3QgY291bnQgdHJhaWxpbmcgJ1wwJyBhcyBw
YXJ0IG9mIGxlbmd0aCAqLw0KKyAgICAtLWJ1Zi5sZW47DQorDQogICByZXR1
cm4gYnVmOw0KIH0NCiANCg==

--8323328-1819535020-1101881754=:3572--

