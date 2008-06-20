Message-ID: <44e5dffd0806200615r65f02642hc7fd04d35d2b2a89@...278...>
Date: Fri, 20 Jun 2008 09:15:52 -0400
From: "R Mullen" <rm@...1108...>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5643_31625862.1213967752550"
Subject: [Openvpn-devel] Subnet size limit hardcoded - why?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: skaelin@...1109...

------=_Part_5643_31625862.1213967752550
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

There's a hardcoded size limit in pool.h when assigning the netmask to
your VPN. It only allows you to have /16 networks or smaller, and I
think this should be increased to /8 so that you can use the whole
10.0.0.0/8 subnet as described by RFC 1918 concerning dedicated
private subnets. Naturally, there's no reason anyone would have a
network that size (that's a lot of hosts!)  on a VPN because it's
completely asinine to think that your hardware could support a network
like that running on a single daemon. However, if you are assigning
static IP addresses per host and you have a good reason to want to put
specific hosts on their own smaller /24 subnets, those might add up if
you don't want more than a handful of machines on each /24 net.

I acknowledge the fact that a large network like this is not actually
possible in implementation, but I'm not aware of a good reason why
this hardcoded limit is in place. I've attached a patch created
against version 2.1_rc7, but it should also apply against all versions
in subversion as of today. If  someone knows why this hardcoded limit
is in place, I'd like to know if it's unsafe to run OpenVPN with my
patch applied.

Thanks, and great product!

-- 
rm / 0xCD29EB54

------=_Part_5643_31625862.1213967752550
Content-Type: application/octet-stream; name=openvpn-2.1_rc7-bigpool.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhosxn4q0
Content-Disposition: attachment; filename=openvpn-2.1_rc7-bigpool.patch

ZGlmZiAtTmF1ciBvcGVudnBuLTIuMV9yYzcvcG9vbC5oIG9wZW52cG4tMi4xX3JjNy1iaWdwb29s
L3Bvb2wuaAotLS0gb3BlbnZwbi0yLjFfcmM3L3Bvb2wuaAkyMDA4LTAxLTIzIDE2OjA4OjQxLjAw
MDAwMDAwMCAtMDUwMAorKysgb3BlbnZwbi0yLjFfcmM3LWJpZ3Bvb2wvcG9vbC5oCTIwMDgtMDYt
MjAgMDg6NTk6NDguMDAwMDAwMDAwIC0wNDAwCkBAIC0zMyw4ICszMyw4IEBACiAjaW5jbHVkZSAi
c3RhdHVzLmgiCiAjaW5jbHVkZSAidGhyZWFkLmgiCiAKLSNkZWZpbmUgSUZDT05GSUdfUE9PTF9N
QVggICAgICAgICA2NTUzNgotI2RlZmluZSBJRkNPTkZJR19QT09MX01JTl9ORVRCSVRTICAgIDE2
CisjZGVmaW5lIElGQ09ORklHX1BPT0xfTUFYICAgICAgICAgMTY3NzcyMTYKKyNkZWZpbmUgSUZD
T05GSUdfUE9PTF9NSU5fTkVUQklUUyAgICA4CiAKICNkZWZpbmUgSUZDT05GSUdfUE9PTF8zME5F
VCAgIDAKICNkZWZpbmUgSUZDT05GSUdfUE9PTF9JTkRJViAgIDEK
------=_Part_5643_31625862.1213967752550--

