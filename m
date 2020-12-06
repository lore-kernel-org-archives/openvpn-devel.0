Date: Sun, 6 Dec 2020 19:47:49 +0100 (CET)
Message-Id: <202012061847.0B6IlnG5018562@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201206125711.12071-1-gert@...1296...>
References: <20201206125711.12071-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix line number reporting on
 config file errors after <inline> segments
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master, release/2.5 and release/2.4 branch
(bugfix).  

Release/2.4 has the same code, but is missing one recent round of 
uncrustification, many conflicts due to different context and one
due to the new inline-file-handling.

Theoretically it could also be applied to release/2.3, but since it's not 
a really *important* bugfix (= nobody but me noticed in 10+ years), I've 
withstood the temptation.

I have adjusted the line break as instructed (creating two lines with 86 chars).

commit a686f7e29af012783371f401f394ac1e62e5b75f (master)
commit 97af8b3101af6a1f8fef778d2c9e0e5f13d2d440 (release/2.5)
commit 8ce5a319fd7a9b13ed6fee92fbda567c24f832c5 (release/2.4)
Author: Gert Doering
Date:   Sun Dec 6 13:57:11 2020 +0100

     Fix line number reporting on config file errors after <inline> segments

     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20201206125711.12071-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21334.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


