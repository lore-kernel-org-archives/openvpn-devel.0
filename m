Date: Mon, 3 Feb 2025 13:48:42 +0100 (CET)
Message-Id: <202502031248.513CmgJg088015@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250131205727.60957-1-smittals@...2857...>
References: <20250131205727.60957-1-smittals@...2857...>
Subject: [Openvpn-devel] [PATCH applied] Re: Adding AWS-LC to the OpenVPN CI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Shubham Mittal <smittals@...2857...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

For future submissions, please take a few things into account to make
our lives easier

  - please do not include the "Acked-By:" lines - this is added by me,
    after seeing a formal ACK on the mailing list or in Gerrit.
    Github PR reviews are not considered "formal ACK" for OpenVPN main
    (transparency and archiving requirements), as of today.

  - if you send a new version of the patch, please include "-v2", "-v3"
    etc. in the git-send-email (or git-format-patch) command, so it's
    clear which e-mail is which patch version, and also to which version
    a comment on the list applies.

thanks :-)

commit 060ead650450553214dad3e9856c500deb672bba
Author: Shubham Mittal
Date:   Fri Jan 31 12:57:27 2025 -0800

     Adding AWS-LC to the OpenVPN CI

     Signed-off-by: Shubham Mittal <smittals@...2857...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20250131205727.60957-1-smittals@...2857...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30776.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


