References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
	<8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
From: Lev Stipakov <lstipakov@...277...>
Message-ID: <3df7b1d7-37f5-6f65-8c54-f2fe69e42f49@...277...>
Date: Tue, 13 Dec 2016 10:24:47 +0200
MIME-Version: 1.0
In-Reply-To: <8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
	--enable-plugins
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

13.12.2016, 02:15, David Sommerseth kirjoitti:

> Coupling --enable-async-push with --enable-plugins makes a lot of sense.
>  By the way, there is a typo in the errror message though
> (--enable_async_push should be --enable-async-push).

Yes :(

I wonder if actual committer could fix it or should I send V2.

> regardless.  I think it is more likely that those adding
> --disable-plugins (it is enabled by default) believe --enable-async-push
> does something completely different.  Rather have in the help line of
> --enable-async-push that it depends on the plug-in feature.

I do not have a strong opinion about that, but IMO having both 
--enable-async-push (1) and --disable-plugins (2) is a configuration 
error, since feature (1) depends on feature (2) and warn about it during 
build phase is more clear rather than silently disable feature (1).

I could send V2 with fixed error message and clarified async-push help 
line, or alternatively V2 with clarified help line and fix in syshead.h 
you've suggested :)

-Lev


