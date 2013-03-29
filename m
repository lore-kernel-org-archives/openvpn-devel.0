Message-ID: <5155D043.70202@...515...>
Date: Fri, 29 Mar 2013 19:32:51 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000500000709090906020508"
Subject: [Openvpn-devel] OpenVPN 2.3.1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000500000709090906020508
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.3.1. It
can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

This release adds supports for PolarSSL 1.2. It also adds a fix to
prevent potential side-channel attacks by switching to a constant-time
memcmp when comparing HMACs in the openvpn_decrypt function. In
addition, it contains several bugfixes and documentation updates, as
well as some minor enhancements. A full list of changes is available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

The changelog is also attached to this email.

For generic help use these support channels:

- Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
- Wiki: <https://community.openvpn.net>
- Forums: <https://forums.openvpn.net>
- User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

- Bug tracker and Wiki: <https://community.openvpn.net>
- Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
  Freenode registration)

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------000500000709090906020508
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.3.1-changelog.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.3.1-changelog.txt"

QXJuZSBTY2h3YWJlICg0KToKICAgICAgUmVtb3ZlIGRlYWQgY29kZSBwYXRoIGFuZCBwdXRl
bnYgZnVuY3Rpb25hbGl0eQogICAgICBSZW1vdmUgdW51c2VkIGZ1bmN0aW9uIHhvcgogICAg
ICBNb3ZlIHN0YXRpYyBwcm90b3R5cGUgZGVmaW5pdGlvbiBmcm9tIGhlYWRlciBpbnRvIGMg
ZmlsZQogICAgICBSZW1vdmUgdW51c2VkIGZ1bmN0aW9uIG5vX3RhcF9pZmNvbmZpZwoKQ2hy
aXN0aWFuIEhlc3NlICgxKToKICAgICAgZml4IGJ1aWxkIHdpdGggYXV0b21ha2UgMS4xMygu
MSkKCkNocmlzdGlhbiBOaWVzc25lciAoMSk6CiAgICAgIEZpeCBjb3JuZXIgY2FzZSBpbiBO
VExNIGF1dGhlbnRpY2F0aW9uICh0cmFjICMxNzIpCgpHZXJ0IERvZXJpbmcgKDYpOgogICAg
ICBVcGRhdGUgUkVBRE1FLklQdjYgdG8gbWF0Y2ggd2hhdCBpcyBpbiAyLjMuMAogICAgICBS
ZXBhaXIgInRjcCBzZXJ2ZXIgcXVldWUgb3ZlcmZsb3ciIGJyb2tlbm5lc3MsIG1vcmUgPHN0
ZGJvb2wuaD4gZmFsbG91dC4KICAgICAgUGVybWl0IHBvb2wgc2l6ZSBvZiAvNjQuLi4vMTEy
IGZvciBpZmNvbmZpZy1pcHY2LXBvb2wKICAgICAgQWRkIE1JTigpIGNvbXBhdGliaWxpdHkg
bWFjcm8KICAgICAgRml4IGRpcmVjdGx5IGNvbm5lY3RlZCByb3V0ZXMgZm9yICJ0b3BvbG9n
eSBzdWJuZXQiIG9uIFNvbGFyaXMuCiAgICAgIFByZXBhcmluZyBmb3IgdjIuMy4xIChDaGFu
Z2VMb2csIHZlcnNpb24ubTQpCgpIZWlrbyBIdW5kICg1KToKICAgICAgY2xvc2UgbW9yZSBm
aWxlIGRlc2NyaXB0b3JzIG9uIGV4ZWMKICAgICAgSWdub3JlIFVURi04IGJ5dGUgb3JkZXIg
bWFyawogICAgICByZWludHJvZHVjZSAtLW5vLW5hbWUtcmVtYXBwaW5nIG9wdGlvbgogICAg
ICBtYWtlIC0tdGxzLXJlbW90ZSBjb21wYXRpYmxlIHdpdGggcHJlIDIuMyBjb25maWdzCiAg
ICAgIGFkZCBuZXcgb3B0aW9uIGZvciBYLjUwOSBuYW1lIHZlcmlmaWNhdGlvbgoKSmFuIEp1
c3QgS2VpanNlciAoMSk6CiAgICAgIG1hbiBwYWdlIHBhdGNoIGZvciBtaXNzaW5nIG9wdGlv
bnMKCkpvc2ggQ2VwZWsgKDIpOgogICAgICBGaXggcGFyYW1ldGVyIGxpc3RpbmcgaW4gbm9u
LWRlYnVnIGJ1aWxkcyBhdCB2ZXJiIDQKICAgICAgKHVwZGF0ZWQpIFtQQVRDSF0gV2FybiB3
aGVuIHVzaW5nIHZlcmIgbGV2ZWxzID49NyB3aXRob3V0IGRlYnVnCgpNYXR0aGlhcyBBbmRy
ZWUgKDEpOgogICAgICBFbmFibGUgVENQX05PREVMQVkgY29uZmlndXJhdGlvbiBvbiBGcmVl
QlNELgoKU2FtdWxpIFNlcHDDpG5lbiAoNCk6CiAgICAgIFJlbW92ZWQgQ2hhbmdlTG9nLklQ
djYKICAgICAgQWRkZWQgY3Jvc3MtY29tcGlsYXRpb24gaW5mb3JtYXRpb24gSU5TVEFMTC13
aW4zMi50eHQKICAgICAgVXBkYXRlZCBSRUFETUUKICAgICAgQ2xlYW5lZCB1cCBhbmQgdXBk
YXRlZCBJTlNUQUxMCgpTdGVmZmFuIEthcmdlciAoNyk6CiAgICAgIFBvbGFyU1NMLTEuMiBz
dXBwb3J0CiAgICAgIEltcHJvdmUgUG9sYXJTU0wga2V5X3N0YXRlX3JlYWRfe2NpcGhlciwg
cGxhaW59dGV4dCBtZXNzYWdlcwogICAgICBJbXByb3ZlIHZlcmlmeV9jYWxsYmFjayBtZXNz
YWdlcwogICAgICBDb25maWcgY29tcGF0aWJpbGl0eSBwYXRjaC4gQWRkZWQgdHJhbnNsYXRl
X2NpcGhlcl9uYW1lLgogICAgICBTd2l0Y2ggdG8gSUFOQSBuYW1lcyBmb3IgVExTIGNpcGhl
cnMuCiAgICAgIEZpeGVkIGF1dG9jb25mIHNjcmlwdCB0byBwcm9wZXJseSBkZXRlY3QgbWlz
c2luZyBwa2NzMTEgd2l0aCBwb2xhcnNzbC4KICAgICAgVXNlIGNvbnN0YW50IHRpbWUgbWVt
Y21wIHdoZW4gY29tcGFyaW5nIEhNQUNzIGluIG9wZW52cG5fZGVjcnlwdC4KCg==
--------------000500000709090906020508--

