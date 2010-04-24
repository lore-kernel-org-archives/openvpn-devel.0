From: Davide Brini <dave_br@...1278...>
Date: Sat, 24 Apr 2010 13:55:49 +0100
References: <1272109716-3037-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1272109716-3037-1-git-send-email-openvpn.list@...1114...>
MIME-Version: 1.0
Message-Id: <201004241355.49944.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Revamped the script-security warning
	logging
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Saturday 24 April 2010, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> This is a first-cut of removing misleading warnings from the logs.
> 
> The main task of this patch is to avoid reporting the
>  SCRIPT_SECURITY_WARNING over and over again, in addition to not show this
>  warning when it should not be a problem.  This general warning should now
>  only appear once, and only when --script-security is not set, 0 or 1.  In
>  all other cases this warning should not appear.
> 

I haven't tested it yet (so please ignore this message if I'm wrong), but then 
IIUC you still get the warning even if /no/ script at all is defined in the 
configuration (ie, no "up", no "down", etc.). I imagine that getting a warning 
in that case would be even more misleading!

-- 
D.

