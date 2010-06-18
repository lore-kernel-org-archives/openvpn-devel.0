Message-ID: <20100618000120.28120.qmail@...1287...>
Date: Fri, 18 Jun 2010 02:01:20 +0200
From: Peter Stuge <peter@...1287...>
References: <4C19ED93.50202@...1380...>
	<4C1A0941.5000808@...515...>
	<AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>
	<4C1A1AE1.5090305@...1380...>
	<AANLkTimpz7YASaTfmQ5DItwiMrplAx_G93ez2vHxAWW5@...278...>
	<4C1A3658.6090501@...1380...>
	<4C1A7E26.4010206@...1114...>
MIME-Version: 1.0
In-Reply-To: <4C1A7E26.4010206@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to
	be	username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> > 3) "sizeof(common_name)" is useless... Line 745: char
> > common_name[TLS_USERNAME_LEN]; we can use directly TLS_USERNAME_LEN.
> 
> Thanks a lot for the patch and all rework done.  (Also: thank you to all
> reviewers!)
> 
> The third and last patch looks very good!  I've applied it to the
> feat_misc branch and merged it into allmerged.

I strongly agree with Alon about sizeof() rather than a second
reference to the same define. It is the defensive way.


//Peter

