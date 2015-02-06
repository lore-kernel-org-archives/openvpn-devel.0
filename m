MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 6 Feb 2015 14:49:10 -0500
Message-ID: <CAEsd45SoC+h5tcDraZcQN_MUYzqWYOVvNpkwMo190DLpB32StQ@...278...>
Content-Type: multipart/mixed; boundary=e89a8f503a5c4365da050e70b9a3
Subject: [Openvpn-devel] [PATCH] Fix mismatch of fprintf format specifier
	and argument type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--e89a8f503a5c4365da050e70b9a3
Content-Type: text/plain; charset=UTF-8

This fixes a warning about a mismatch between a fprintf format string
and an argument type on Darwin-64-bit builds:

%lu specifies type 'unsigned long' but the argument has type
'__darwin_suseconds_t' (aka 'int')

--e89a8f503a5c4365da050e70b9a3
Content-Type: text/plain; charset=US-ASCII;
	name="fix-format-argument-mismatch.diff"
Content-Disposition: attachment; filename="fix-format-argument-mismatch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i5tzdoo30

LS0tIG9wZW52cG4vc3JjL29wZW52cG4vZXJyb3IuYyAyMDE1LTAxLTIzIDEzOjE3OjUwLjAwMDAw
MDAwMCAtMDUwMAorKysgcGF0Y2hlZC9zcmMvb3BlbnZwbi9lcnJvci5jIDIwMTUtMDItMDMgMjI6
MTI6MzIuMDAwMDAwMDAwIC0wNTAwCkBAIC0zMTksNyArMzE5LDcgQEAKIAogCSAgICAgIGZwcmlu
dGYgKGZwLCAiJWx1LiUwNmx1ICV4ICVzJXMlcyVzIiwKIAkJICAgICAgIHR2LnR2X3NlYywKLQkJ
ICAgICAgIHR2LnR2X3VzZWMsCisJCSAgICAgICAodW5zaWduZWQgbG9uZyl0di50dl91c2VjLAog
CQkgICAgICAgZmxhZ3MsCiAJCSAgICAgICBwcmVmaXgsCiAJCSAgICAgICBwcmVmaXhfc2VwLAo=
--e89a8f503a5c4365da050e70b9a3--

