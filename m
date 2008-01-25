Message-ID: <9e0cf0bf0801251544s6a13dbfdx1148dd15d74e282a@...278...>
Date: Sat, 26 Jan 2008 01:44:38 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <9e0cf0bf0801251057o42f15467g422a97500d349e95@...278...>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1024_9445620.1201304678295"
References: <4797B53E.4020007@...41...>
	<20080125170022.GA23938@...611...>
	<9e0cf0bf0801251057o42f15467g422a97500d349e95@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1-rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steven Pritchard <steve@...609...>
Cc: Openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

------=_Part_1024_9445620.1201304678295
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well...
From: http://bugs.gentoo.org/show_bug.cgi?id=207320, found out that:
When executing:
ip addr flush dev XXXX
On unprivileged user, you get infinite loop of iproute2... Reported
this to upstream.
So I had to workaround this using explicit del.

-r 2677:2682 https://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21-userpriv-fixups

On 1/25/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Thanks!
> I was not aware of the null tun.
> The following should fix the problem.
>
> -r 2677:2679 https://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21-userpriv-fixups
>
> Alon.
>
> On 1/25/08, Steven Pritchard <steve@...609...> wrote:
> > Trying to build the Fedora package for rc6, I'm getting an error from
> > %check, which basically does this:
> >
> >   ./openvpn --config sample-config-files/loopback-client &
> >   ./openvpn --config sample-config-files/loopback-server
> >   wait
> >
> > I'm getting the following error:
> >
> >   Thu Jan 24 14:15:33 2008 /sbin/ip addr flush dev null
> >   Device "null" does not exist.
> >   Thu Jan 24 14:15:33 2008 Linux ip flush failed: shell command exited with error status: 255
> >
> > Full build log here:
> >
> >   http://koji.fedoraproject.org/koji/getfile?taskID=370966&name=build.log
> >
> > Steve
> > --
> > Steven Pritchard - K&S Pritchard Enterprises, Inc.
> > Email: steve@...610...             http://www.kspei.com/
> > Phone: (618)624-4440               Mobile: (618)567-7320
> >
> > -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2008.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>
>

------=_Part_1024_9445620.1201304678295
Content-Type: text/x-diff; name=BETA21-userpriv-fixups.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbvds8o3
Content-Disposition: attachment; filename=BETA21-userpriv-fixups.patch

SW5kZXg6IG9wZW52cG4vdHVuLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gb3BlbnZwbi90dW4uYwkocmV2aXNp
b24gMjY3NykKKysrIG9wZW52cG4vdHVuLmMJKHJldmlzaW9uIDI2ODIpCkBAIC0xMjIxLDE3ICsx
MjIxLDI0IEBACiAgIGlmICh0dCkKICAgICB7CiAjaWZkZWYgQ09ORklHX0ZFQVRVUkVfSVBST1VU
RQotCWNoYXIgY29tbWFuZF9saW5lWzI1Nl07Ci0JLyoKLQkgKiBGbHVzaCBJUCBjb25maWd1cmF0
aW9uIGZvciB0aGUgZGV2aWNlCi0JICovCi0Jb3BlbnZwbl9zbnByaW50ZiAoY29tbWFuZF9saW5l
LCBzaXplb2YgKGNvbW1hbmRfbGluZSksCi0JCQkgICIlcyBhZGRyIGZsdXNoIGRldiAlcyIsCisJ
aWYgKHR0LT50eXBlICE9IERFVl9UWVBFX05VTEwgJiYgdHQtPmRpZF9pZmNvbmZpZykKKwkgIHsK
KwkgICAgY2hhciBjb21tYW5kX2xpbmVbMjU2XTsKKwkgICAgc3RydWN0IGdjX2FyZW5hIGdjID0g
Z2NfbmV3ICgpOworCisJICAgIG9wZW52cG5fc25wcmludGYgKGNvbW1hbmRfbGluZSwgc2l6ZW9m
IChjb21tYW5kX2xpbmUpLAorCQkJICAiJXMgYWRkciBkZWwgZGV2ICVzIGxvY2FsICVzIHBlZXIg
JXMiLAogCQkJICBpcHJvdXRlX3BhdGgsCi0JCQkgIHR0LT5hY3R1YWxfbmFtZQorCQkJICB0dC0+
YWN0dWFsX25hbWUsCisJCQkgIHByaW50X2luX2FkZHJfdCAodHQtPmxvY2FsLCAwLCAmZ2MpLAor
CQkJICBwcmludF9pbl9hZGRyX3QgKHR0LT5yZW1vdGVfbmV0bWFzaywgMCwgJmdjKQogCQkJICAp
OwotCW1zZyAoTV9JTkZPLCAiJXMiLCBjb21tYW5kX2xpbmUpOwotCXN5c3RlbV9jaGVjayAoY29t
bWFuZF9saW5lLCBOVUxMLCBTX0ZBVEFMLCAiTGludXggaXAgZmx1c2ggZmFpbGVkIik7CisKKwkg
ICAgbXNnIChNX0lORk8sICIlcyIsIGNvbW1hbmRfbGluZSk7CisJICAgIHN5c3RlbV9jaGVjayAo
Y29tbWFuZF9saW5lLCBOVUxMLCBTX0ZBVEFMLCAiTGludXggaXAgYWRkciBkZWwgZmFpbGVkIik7
CisKKwkgICAgZ2NfZnJlZSAoJmdjKTsKKwkgIH0KICNlbmRpZgogICAgICAgY2xvc2VfdHVuX2dl
bmVyaWMgKHR0KTsKICAgICAgIGZyZWUgKHR0KTsK
------=_Part_1024_9445620.1201304678295--

