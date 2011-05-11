MIME-Version: 1.0
Date: Wed, 11 May 2011 17:57:28 -0400
Message-ID: <BANLkTimDEA004RuTcUBKDXPWffEWBo3-iw@...278...>
From: "Matthew L. Creech" <mlcreech@...277...>
Content-Type: multipart/mixed; boundary=20cf307f395e9e12e204a3072848
Subject: [Openvpn-devel] [PATCH] fix 2.2.0 build failure when management
	interface disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--20cf307f395e9e12e204a3072848
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I just upgraded to 2.2.0, and my build fails with:

ps.c: In function 'port_share_open':
ps.c:778:7: error: 'management' undeclared (first use in this function)
ps.c:778:7: note: each undeclared identifier is reported only once for
each function it appears in
make[5]: *** [ps.o] Error 1

The attached patch fixed the problem.

-- 
Matthew L. Creech

--20cf307f395e9e12e204a3072848
Content-Type: text/x-patch; charset=US-ASCII; name="01-no-management.patch"
Content-Disposition: attachment; filename="01-no-management.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnkt7d2q0

ZGlmZiAtcHVyTiBvcmlnL3BzLmMgb3BlbnZwbi0yLjIuMC9wcy5jCi0tLSBvcmlnL3BzLmMJMjAx
MS0wNS0xMSAxNzo0Mzo0My41NTIwMzIyNDQgLTA0MDAKKysrIG9wZW52cG4tMi4yLjAvcHMuYwky
MDExLTA1LTExIDE3OjQ0OjE0LjQ5MjAzMTczMCAtMDQwMApAQCAtNzc0LDggKzc3NCwxMCBAQCBw
b3J0X3NoYXJlX29wZW4gKGNvbnN0IGNoYXIgKmhvc3QsIGNvbnN0CiAgICAgICAvKiBMZXQgbXNn
IGtub3cgdGhhdCB3ZSBmb3JrZWQgKi8KICAgICAgIG1zZ19mb3JrZWQgKCk7CiAKKyNpZmRlZiBN
QU5BR0VNRU5UX0VOQUJMRUQKICAgICAgIC8qIERvbid0IGludGVyYWN0IHdpdGggbWFuYWdlbWVu
dCBpbnRlcmZhY2UgKi8KICAgICAgIG1hbmFnZW1lbnQgPSBOVUxMOworI2VuZGlmCiAKICAgICAg
IC8qIGNsb3NlIGFsbCBwYXJlbnQgZmRzIGV4Y2VwdCBvdXIgc29ja2V0IGJhY2sgdG8gcGFyZW50
ICovCiAgICAgICBjbG9zZV9mZHNfZXhjZXB0IChmZFsxXSk7Cg==
--20cf307f395e9e12e204a3072848--

