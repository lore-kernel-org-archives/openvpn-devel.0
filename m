Message-ID: <9e0cf0bf0801251057o42f15467g422a97500d349e95@...278...>
Date: Fri, 25 Jan 2008 20:57:07 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <20080125170022.GA23938@...611...>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_138_25076241.1201287427354"
References: <4797B53E.4020007@...41...>
	<20080125170022.GA23938@...611...>
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

------=_Part_138_25076241.1201287427354
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks!
I was not aware of the null tun.
The following should fix the problem.

-r 2677:2679 https://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21-userpriv-fixups

Alon.

On 1/25/08, Steven Pritchard <steve@...609...> wrote:
> Trying to build the Fedora package for rc6, I'm getting an error from
> %check, which basically does this:
>
>   ./openvpn --config sample-config-files/loopback-client &
>   ./openvpn --config sample-config-files/loopback-server
>   wait
>
> I'm getting the following error:
>
>   Thu Jan 24 14:15:33 2008 /sbin/ip addr flush dev null
>   Device "null" does not exist.
>   Thu Jan 24 14:15:33 2008 Linux ip flush failed: shell command exited with error status: 255
>
> Full build log here:
>
>   http://koji.fedoraproject.org/koji/getfile?taskID=370966&name=build.log
>
> Steve
> --
> Steven Pritchard - K&S Pritchard Enterprises, Inc.
> Email: steve@...610...             http://www.kspei.com/
> Phone: (618)624-4440               Mobile: (618)567-7320
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

------=_Part_138_25076241.1201287427354
Content-Type: text/x-diff; name=BETA21-userpriv-fixups.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbv3hu61
Content-Disposition: attachment; filename=BETA21-userpriv-fixups.patch

SW5kZXg6IG9wZW52cG4vdHVuLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gb3BlbnZwbi90dW4uYwkocmV2aXNp
b24gMjY3NykKKysrIG9wZW52cG4vdHVuLmMJKHJldmlzaW9uIDI2NzkpCkBAIC0xMjIxLDE3ICsx
MjIxLDIwIEBACiAgIGlmICh0dCkKICAgICB7CiAjaWZkZWYgQ09ORklHX0ZFQVRVUkVfSVBST1VU
RQotCWNoYXIgY29tbWFuZF9saW5lWzI1Nl07Ci0JLyoKLQkgKiBGbHVzaCBJUCBjb25maWd1cmF0
aW9uIGZvciB0aGUgZGV2aWNlCi0JICovCi0Jb3BlbnZwbl9zbnByaW50ZiAoY29tbWFuZF9saW5l
LCBzaXplb2YgKGNvbW1hbmRfbGluZSksCisJaWYgKHR0LT50eXBlICE9IERFVl9UWVBFX05VTEwp
CisJICB7CisJICAgIGNoYXIgY29tbWFuZF9saW5lWzI1Nl07CisJICAgIC8qCisJICAgICAqIEZs
dXNoIElQIGNvbmZpZ3VyYXRpb24gZm9yIHRoZSBkZXZpY2UKKwkgICAgICovCisJICAgIG9wZW52
cG5fc25wcmludGYgKGNvbW1hbmRfbGluZSwgc2l6ZW9mIChjb21tYW5kX2xpbmUpLAogCQkJICAi
JXMgYWRkciBmbHVzaCBkZXYgJXMiLAogCQkJICBpcHJvdXRlX3BhdGgsCiAJCQkgIHR0LT5hY3R1
YWxfbmFtZQogCQkJICApOwotCW1zZyAoTV9JTkZPLCAiJXMiLCBjb21tYW5kX2xpbmUpOwotCXN5
c3RlbV9jaGVjayAoY29tbWFuZF9saW5lLCBOVUxMLCBTX0ZBVEFMLCAiTGludXggaXAgZmx1c2gg
ZmFpbGVkIik7CisJICAgIG1zZyAoTV9JTkZPLCAiJXMiLCBjb21tYW5kX2xpbmUpOworCSAgICBz
eXN0ZW1fY2hlY2sgKGNvbW1hbmRfbGluZSwgTlVMTCwgU19GQVRBTCwgIkxpbnV4IGlwIGZsdXNo
IGZhaWxlZCIpOworCSAgfQogI2VuZGlmCiAgICAgICBjbG9zZV90dW5fZ2VuZXJpYyAodHQpOwog
ICAgICAgZnJlZSAodHQpOwo=
------=_Part_138_25076241.1201287427354--

