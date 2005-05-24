Message-ID: <20050524103719.28597.qmail@...403...>
From: Jesse Adelman <jesse@...402...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1554598473-1116931039=:26002"
Subject: [Openvpn-devel] client-up/client-down scripts
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
Date: Tue May 24 03:40:52 2005
To: openvpn-devel@lists.sourceforge.net

--0-1554598473-1116931039=:26002
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, good OpenVPN devs. I don't really hope to have these simple scripts
integrated into the contrib/ directory in their current form, but I
thought I'd get the ball rolling for others who are more adept than me
to perhaps build on them. Should work for any GNU/Linux system with a
standard /etc/resolv.conf, and an OpenVPN server "push"ing down dhcp
DNS options.

They work very well for me so far, but, YMMV, of course. client.down
won't work unless OpenVPN is running as root, the user OpenVPN is
running under has rights to run the script and to write to
/etc/resolv.conf, or you use the down-root plugin in the plugin/
directory in the OpenVPN source tarball (haven't tried this yet).

Thanks to "UNIX Power Tools (O'Reilly)", "Learning the Bash Shell
(O'Reilly)" and #bash on Freenode for the assistance.

I assign the copyright over to OpenVPN, and releasing these under GPL
v2. I'm sure v3 is great, but I haven't read it yet ;). I'll be glad to
help with bugfixing, as time permits.

Cheers,
Jesse Adelman

-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
Jesse Adelman
http://www.boldandbusted.com/ 
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--0-1554598473-1116931039=:26002
Content-Type: application/octet-stream; name="client.up"
Content-Transfer-Encoding: base64
Content-Description: 885563976-client.up
Content-Disposition: attachment; filename="client.up"

IyEvYmluL2Jhc2gKCiMgQ29weXJpZ2h0IChjKSAyMDA1IGJ5IE9wZW5WUE4g
U29sdXRpb25zIExMQwojIExpY2Vuc2VkIHVuZGVyIHRoZSBHUEwgdmVyc2lv
biAyCgojIEZpcnN0IHZlcnNpb24gYnkgSmVzc2UgQWRlbG1hbgojIHNvbWVv
bmUgYXQgYm9sZGFuZGJ1c3RlZCBkaW5rIGNvbQoKIyBPbmx5IHRlc3RlZCBv
biBHZW50b28gTGludXggMjAwNS4wIHdpdGggT3BlblZQTiAyLjAKIyBJdCBz
aG91bGQgd29yayB3aXRoIGFueSBHTlUvTGludXggd2l0aCAvZXRjL3Jlc29s
di5jb25mCgojIE5vdGUgdGhhdCB0aGlzIHJ1bnMgd2l0aCB0aGUgY29udGV4
dCBvZiB0aGUgT3BlblZQTiBVSUQvR0lEIAojIGF0IHRoZSB0aW1lIG9mIGV4
ZWN1dGlvbi4gVGhpcyBnZW5lcmFsbHkgbWVhbnMgdGhhdAojIHRoZSBjbGll
bnQgInVwIiBzY3JpcHQgd2lsbCBydW4gZmluZSwgYnV0IHRoZSAiZG93biIg
c2NyaXB0CiMgd2lsbCByZXF1aXJlIHRoZSB1c2Ugb2YgdGhlIE9wZW5WUE4g
ImRvd24tcm9vdCIgcGx1Z2luCiMgd2hpY2ggaXMgaW4gdGhlIHBsdWdpbnMv
IGRpcmVjdG9yeSBvZiB0aGUgT3BlblZQTiBzb3VyY2UgdHJlZQoKIyBBIGhv
cnJpZCB3b3JrIGFyb3VuZCwgZnJvbSBhIHNlY3VyaXR5IHBlcnNwZWN0aXZl
LAojIGlzIHRvIHJ1biBPcGVuVlBOIGFzIHJvb3QuIFRISVMgSVMgTk9UIFJF
Q09NTUVOREVELiBZb3UgaGF2ZQojIGJlZW4gV0FSTkVELgoKIyBpbml0IHZh
cmlhYmxlcwoKaT0xCmo9MQp1bnNldCBmb3B0CnVuc2V0IGRucwp1bnNldCBv
cHQKCiMgQ29udmVydCBFTlZzIHRvIGFuIGFycmF5Cgp3aGlsZSBmb3B0PWZv
cmVpZ25fb3B0aW9uXyRpOyBbIC1uICIkeyFmb3B0fSIgXTsgZG8KewoJb3B0
W2ktMV09JHshZm9wdH0KCWNhc2UgJHtvcHRbaS0xXX0gaW4KCQkqRE9NQUlO
KiApIGRvbWFpbj1gZWNobyAke29wdFtpLTFdfSB8IFwKCQkJCXNlZCAtZSAn
cy9kaGNwLW9wdGlvbiBET01BSU4gLy9nJ2AgOzsKCQkqRE5TKiAgICApIGRu
c1tqLTFdPWBlY2hvICR7b3B0W2ktMV19IHwgXAoJCQkJc2VkIC1lICdzL2Ro
Y3Atb3B0aW9uIEROUyAvL2cnYAoJCQkgICAgICAgbGV0IGorKyA7OwoJZXNh
YwoJbGV0IGkrKwp9CmRvbmUKCiMgTm93LCBkbyB0aGUgd29yawoKaWYgWyAt
biAiJHtkbnNbKl19IiBdOyB0aGVuCglmb3IgaSBpbiAiJHtkbnNbQF19Ijsg
ZG8KCQlzZWQgLWkgLWUgIjEsMSBpIG5hbWVzZXJ2ZXIgJHtpfSIgL2V0Yy9y
ZXNvbHYuY29uZiB8fCBkaWUKCWRvbmUKZmkKCmlmIFsgLW4gIiR7ZG9tYWlu
fSIgXTsgdGhlbgoJc2VkIC1pIC1lICIkaiwxIGkgc2VhcmNoICR7ZG9tYWlu
fSIgL2V0Yy9yZXNvbHYuY29uZiB8fCBkaWUKZmkKCiMgYWxsIGRvbmUuLi4K
ZXhpdCAwCg==

--0-1554598473-1116931039=:26002
Content-Type: application/octet-stream; name="client.down"
Content-Transfer-Encoding: base64
Content-Description: 4149678061-client.down
Content-Disposition: attachment; filename="client.down"

IyEvYmluL2Jhc2gKCiMgQ29weXJpZ2h0IChjKSAyMDA1IGJ5IE9wZW5WUE4g
U29sdXRpb25zIExMQwojIExpY2Vuc2VkIHVuZGVyIHRoZSBHUEwgdmVyc2lv
biAyCgojIEZpcnN0IHZlcnNpb24gYnkgSmVzc2UgQWRlbG1hbgojIHNvbWVv
bmUgYXQgYm9sZGFuZGJ1c3RlZCBkaW5rIGNvbQoKIyBPbmx5IHRlc3RlZCBv
biBHZW50b28gTGludXggMjAwNS4wIHdpdGggT3BlblZQTiAyLjAKIyBJdCBz
aG91bGQgd29yayB3aXRoIGFueSBHTlUvTGludXggd2l0aCAvZXRjL3Jlc29s
di5jb25mCgojIE5vdGUgdGhhdCB0aGlzIHJ1bnMgd2l0aCB0aGUgY29udGV4
dCBvZiB0aGUgT3BlblZQTiBVSUQvR0lEIAojIGF0IHRoZSB0aW1lIG9mIGV4
ZWN1dGlvbi4gVGhpcyBnZW5lcmFsbHkgbWVhbnMgdGhhdAojIHRoZSBjbGll
bnQgInVwIiBzY3JpcHQgd2lsbCBydW4gZmluZSwgYnV0IHRoZSAiZG93biIg
c2NyaXB0CiMgd2lsbCByZXF1aXJlIHRoZSB1c2Ugb2YgdGhlIE9wZW5WUE4g
ImRvd24tcm9vdCIgcGx1Z2luCiMgd2hpY2ggaXMgaW4gdGhlIHBsdWdpbnMv
IGRpcmVjdG9yeSBvZiB0aGUgT3BlblZQTiBzb3VyY2UgdHJlZQoKIyBBIGhv
cnJpZCB3b3JrIGFyb3VuZCwgZnJvbSBhIHNlY3VyaXR5IHBlcnNwZWN0aXZl
LAojIGlzIHRvIHJ1biBPcGVuVlBOIGFzIHJvb3QuIFRISVMgSVMgTk9UIFJF
Q09NTUVOREVELiBZb3UgaGF2ZQojIGJlZW4gV0FSTkVELgoKIyBpbml0IHZh
cmlhYmxlcwoKaT0xCmo9MQp1bnNldCBmb3B0CnVuc2V0IGRucwp1bnNldCBv
cHQKCiMgQ29udmVydCBFTlZzIHRvIGFuIGFycmF5Cgp3aGlsZSBmb3B0PWZv
cmVpZ25fb3B0aW9uXyRpOyBbIC1uICIkeyFmb3B0fSIgXTsgZG8KewoJb3B0
W2ktMV09JHshZm9wdH0KCWNhc2UgJHtvcHRbaS0xXX0gaW4KCQkqRE9NQUlO
KiApIGRvbWFpbj1gZWNobyAke29wdFtpLTFdfSB8IFwKCQkJCXNlZCAtZSAn
cy9kaGNwLW9wdGlvbiBET01BSU4gLy9nJ2AgOzsKCQkqRE5TKiAgICApIGRu
c1tqLTFdPWBlY2hvICR7b3B0W2ktMV19IHwgXAoJCQkJc2VkIC1lICdzL2Ro
Y3Atb3B0aW9uIEROUyAvL2cnYAoJCQkgICAgICAgbGV0IGorKyA7OwoJZXNh
YwoJbGV0IGkrKwp9CmRvbmUKCiMgTm93LCBkbyB0aGUgd29yawoKaWYgWyAt
biAiJHtkbnNbKl19IiBdOyB0aGVuCglmb3IgaSBpbiAiJHtkbnNbQF19Ijsg
ZG8KCQlzZWQgLWkgLWUgIi9uYW1lc2VydmVyICR7aX0vRCIgL2V0Yy9yZXNv
bHYuY29uZiB8fCBkaWUKCWRvbmUKZmkKCmlmIFsgLW4gIiR7ZG9tYWlufSIg
XTsgdGhlbgoJc2VkIC1pIC1lICIvc2VhcmNoICR7ZG9tYWlufS9EIiAvZXRj
L3Jlc29sdi5jb25mIHx8IGRpZQpmaQoKIyBhbGwgZG9uZS4uLgpleGl0IDAK


--0-1554598473-1116931039=:26002--

