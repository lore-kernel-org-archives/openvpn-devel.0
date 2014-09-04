Message-ID: <54083A17.2010601@...1114...>
Date: Thu, 04 Sep 2014 12:08:23 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1409761417-30948-1-git-send-email-davids@...1347...>
In-Reply-To: <1409761417-30948-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Don't let openvpn_popen() keep zoombies
 around
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Frederic Crozat <fcrozat@...1519...>

On 03/09/14 18:23, davids@...1347... wrote:
> From: David Sommerseth <davids@...1347...>
> 
> Commit 9449e6a9eba30c9ed054f57d630a88c9f087080f introduced the
> openvpn_popen() function to support retrieving passwords via systemd.
> 
> It was discovered that the child processes openvpn fork()ed would
> be lingering around until openvpn stopped.  This was due to the lack
> of a wait() call.
> 
> This patch also cleans up a few minor white-space issues in the same
> code segment.
> 
> Cc: Frederic Crozat <fcrozat@...1519...>
> Signed-off-by: David Sommerseth <davids@...1347...>

I've received some feedback privately on this patch.  I will post a new
one in the following days, fixing up a minor thing and some other
aspects too.


-- 
kind regards,

David Sommerseth

