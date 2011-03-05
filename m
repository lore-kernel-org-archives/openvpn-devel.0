Message-ID: <4D717DB0.3030107@...1030...>
Date: Sat, 05 Mar 2011 00:02:56 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4D713CD3.3000606@...515...>	<AANLkTin4QkZ36mi7qHyB9R+i1FdQJi66mi6nhhvYMWmN@...278...>
	<4D716245.6040500@...1114...>
In-Reply-To: <4D716245.6040500@...1114...>
Content-Type: multipart/mixed; boundary="------------060108060906010906070108"
Subject: Re: [Openvpn-devel] OpenVPN 2.2-RC released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060108060906010906070108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> Any reason why the windows cross compile fix we discussed [1] did not
>> made it into mainline?
>>
>> This is trivial patch, which resume the ability to build openvpn using
>> cross compiler and autotools.
>>
>> Please apply so we don't need to maintain this out of tree.
>> You can test build at [2].
>>     
>
> I'm sorry, that patch has slipped my patch queue.  The patch applies pretty
> cleanly to the beta2.2 branch (just some offset values which are wrong).
> So I am willing to include that into the final 2.2 release.
>   
Speaking of which, I also proposed a (rather trivial) patch which 
enables cross compilation of a number of OpenVPN plugins (that patch is 
attached again) as in the 2.1.4 version that was not possible.

This was ACKed by you (see the "[OpenVPN 2.1.4 BUG]: hard-coded values 
in Makefiles for down-root and auth-pam plugins prevent cross 
compilation" thread for more details) on 30/12/2010, though I am unsure 
as to whether it would make it for the 2.2 release. Any progress on that?


--------------060108060906010906070108
Content-Type: text/plain; charset="utf-8"; name=openvpn-2.1.4-plugins.patch
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="openvpn-2.1.4-plugins.patch"

ZGlmZiAtTnVyQmIgb3BlbnZwbi0yLjEuNC9wbHVnaW4vYXV0aC1wYW0vTWFrZWZpbGUgYS9wbHVn
aW4vYXV0aC1wYW0vTWFrZWZpbGUNCi0tLSBvcGVudnBuLTIuMS40L3BsdWdpbi9hdXRoLXBhbS9N
YWtlZmlsZQkyMDEwLTEwLTIxIDE4OjM3OjUxLjAwMDAwMDAwMCArMDEwMA0KKysrIGEvcGx1Z2lu
L2F1dGgtcGFtL01ha2VmaWxlCTIwMTAtMTItMjYgMDE6NTc6NDUuMzQ1NzU0MDAwICswMDAwDQpA
QCAtMTUsMTYgKzE1LDE0IEBADQogIyBUaGlzIGRpcmVjdG9yeSBpcyB3aGVyZSB3ZSB3aWxsIGxv
b2sgZm9yIG9wZW52cG4tcGx1Z2luLmgNCiBJTkNMVURFPS1JLi4vLi4NCiANCi1DQ19GTEFHUz0t
TzIgLVdhbGwgLURETE9QRU5fUEFNPSQoRExPUEVOX1BBTSkNCi0NCiBvcGVudnBuLWF1dGgtcGFt
LnNvIDogYXV0aC1wYW0ubyBwYW1kbC5vDQotCWdjYyAke0NDX0ZMQUdTfSAtZlBJQyAtc2hhcmVk
IC1XbCwtc29uYW1lLG9wZW52cG4tYXV0aC1wYW0uc28gLW8gb3BlbnZwbi1hdXRoLXBhbS5zbyBh
dXRoLXBhbS5vIHBhbWRsLm8gLWxjICQoTElCUEFNKQ0KKwkke0NDfSAtRERMT1BFTl9QQU09JChE
TE9QRU5fUEFNKSAtZlBJQyAtc2hhcmVkICR7TERGTEFHU30gLVdsLC1zb25hbWUsb3BlbnZwbi1h
dXRoLXBhbS5zbyAtbyBvcGVudnBuLWF1dGgtcGFtLnNvIGF1dGgtcGFtLm8gcGFtZGwubyAtbGMg
JChMSUJQQU0pDQogDQogYXV0aC1wYW0ubyA6IGF1dGgtcGFtLmMgcGFtZGwuaA0KLQlnY2MgJHtD
Q19GTEFHU30gLWZQSUMgLWMgJHtJTkNMVURFfSBhdXRoLXBhbS5jDQorCSR7Q0N9ICR7Q0ZMQUdT
fSAtRERMT1BFTl9QQU09JChETE9QRU5fUEFNKSAtZlBJQyAtYyAke0lOQ0xVREV9IGF1dGgtcGFt
LmMNCiANCiBwYW1kbC5vIDogcGFtZGwuYyBwYW1kbC5oDQotCWdjYyAke0NDX0ZMQUdTfSAtZlBJ
QyAtYyAke0lOQ0xVREV9IHBhbWRsLmMNCisJJHtDQ30gJHtDRkxBR1N9IC1ERExPUEVOX1BBTT0k
KERMT1BFTl9QQU0pIC1mUElDIC1jICR7SU5DTFVERX0gcGFtZGwuYw0KIA0KIGNsZWFuIDoNCiAJ
cm0gLWYgKi5vICouc28NCmRpZmYgLU51ckJiIG9wZW52cG4tMi4xLjQvcGx1Z2luL2Rvd24tcm9v
dC9NYWtlZmlsZSBhL3BsdWdpbi9kb3duLXJvb3QvTWFrZWZpbGUNCi0tLSBvcGVudnBuLTIuMS40
L3BsdWdpbi9kb3duLXJvb3QvTWFrZWZpbGUJMjAxMC0xMC0yMSAxODozNzo1MS4wMDAwMDAwMDAg
KzAxMDANCisrKyBhL3BsdWdpbi9kb3duLXJvb3QvTWFrZWZpbGUJMjAxMC0xMi0yNiAwMTo1ODow
Ny45NzY3NTUwMDAgKzAwMDANCkBAIC01LDEzICs1LDExIEBADQogIyBUaGlzIGRpcmVjdG9yeSBp
cyB3aGVyZSB3ZSB3aWxsIGxvb2sgZm9yIG9wZW52cG4tcGx1Z2luLmgNCiBJTkNMVURFPS1JLi4v
Li4NCiANCi1DQ19GTEFHUz0tTzIgLVdhbGwNCi0NCiBkb3duLXJvb3Quc28gOiBkb3duLXJvb3Qu
bw0KLQlnY2MgJHtDQ19GTEFHU30gLWZQSUMgLXNoYXJlZCAtV2wsLXNvbmFtZSxvcGVudnBuLWRv
d24tcm9vdC5zbyAtbyBvcGVudnBuLWRvd24tcm9vdC5zbyBkb3duLXJvb3QubyAtbGMNCisJJHtD
Q30gLWZQSUMgLXNoYXJlZCAke0xERkxBR1N9IC1XbCwtc29uYW1lLG9wZW52cG4tZG93bi1yb290
LnNvIC1vIG9wZW52cG4tZG93bi1yb290LnNvIGRvd24tcm9vdC5vIC1sYw0KIA0KIGRvd24tcm9v
dC5vIDogZG93bi1yb290LmMNCi0JZ2NjICR7Q0NfRkxBR1N9IC1mUElDIC1jICR7SU5DTFVERX0g
ZG93bi1yb290LmMNCisJJHtDQ30gJHtDRkxBR1N9IC1mUElDIC1jICR7SU5DTFVERX0gZG93bi1y
b290LmMNCiANCiBjbGVhbiA6DQogCXJtIC1mICoubyAqLnNvDQo=

--------------060108060906010906070108--

