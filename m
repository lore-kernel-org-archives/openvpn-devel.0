From: Wayne Davison <wayne@...2099...>
Date: Tue,  8 Dec 2015 18:28:47 +0000
Message-Id: <1449599329-12968-1-git-send-email-wayne@...2099...>
Subject: [Openvpn-devel] [PATCH 0/2] Fix CR prompt with --auth-user-pass + R
	from a file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

There is a bug in the challenge/response code when the username & password
is read from a file -- the response is never prompted for.  This bug affects
older versions, including 2.3.8.  The following patchset applies to master,
and uses a similar bool idiom as what has been added for user & pass.

I also added code to read the response out of the --auth-user-pass file if
there is a 3rd line present.  This is particularly useful for an 2FA setup
where the response is unchanging (in my case it is always "push" for a Duo
Push).

The master branch already supports treating an empty password in the file as
indicating that the password should be prompted from the user (2.3.8 used to
complain), so I also amended the manpage to mention that the password can be
empty in addition to its line not being present.  This allows me to use a file
that contains user / empty-pass / "push" and have openvpn just prompt me for my
password.

I've broken the patch up into 2 parts for clarity, since it re-indents a large
section of code.  The 2nd patch also fixes an off-by-one indentation that is in
the same file.  Feel free to merge the patches together, as you see fit.


