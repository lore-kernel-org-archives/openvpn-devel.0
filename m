Date: Tue, 21 Feb 2017 14:46:38 +0100 (CET)
Message-Id: <201702211346.v1LDkc1g022695@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170125205302.23069-1-davids@...515...>
References: <20170125205302.23069-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools: Simple tool wihch
	automates rebasing LZ4 compat library
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the master branch.

Some comments:

 - I'm not putting this into release/2.4 branch, as we're only ever going
   to use it in master - lz4 changes get applied to master, and then
   cherrypicked to other branches.

 - the sed statement has been fix-on-commit'ed as discussed on the list

 - a small grammatical mistake in the comment added to the newly imported
   compat-lz4.c has been fixed ("This file *has* been...")

 - typo in the commit message fixed ("wihch")

commit fce9d75b2c44c354457522643eddc914e41f2d84
Author: David Sommerseth
Date:   Wed Jan 25 21:53:02 2017 +0100

     dev-tools: Simple tool which automates rebasing LZ4 compat library

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170125205302.23069-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13962.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


