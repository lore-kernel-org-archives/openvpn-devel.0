From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 16 Nov 2015 11:06:58 +0200
Message-ID: <56499CB2.9020405@...277...>
References: <1425307803-14166-1-git-send-email-lstipakov@...277...>
	<1444747558-23291-1-git-send-email-lstipakov@...277...>
	<20151114194047.GA24952@...1296...>
Mime-Version: 1.0
In-Reply-To: <20151114194047.GA24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Notify clients about server's
	exit/restart
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

>     Since the new server side code does not actually *do* OCC any more we
>     are just #ifdef'ing it to access options->ce.explicit_exit_notify
>     because that one is only compiled in #ifdef ENABLE_OCC ... so we're
>     coupling this new functionality to an #ifdef which is not really
>     relevant.
>
>     No good suggestion yet, just expressing thoughts...
>

Since connection_entry->explicit_exit_notification is now used also 
outside of OCC context, I suggest to:

1) Remove #ifdef ENABLE_OCC around it's definition.

2) Fix comment there:

/* Explicitly tell peer when we are exiting via OCC_EXIT or control 
channel [RESTART] message */

3) Remove (unneeded anymore) #ifdef in multi_process_signal around 
accessing explicit_exit_notification.

What do you think?

-Lev





