Message-Id: <200212200751.gBK7pjf19056@...41...>
Subject: Re: Re[2]: [Openvpn-devel] [PATCH] Exec scripts at sigusr1 and established tunnel
From: "James Yonan" <jim@...41...>
In-Reply-To: <33237207946.20021219175054@...60...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Dec 19 23:53:01 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Richard Mueller <mueller@...60...>, openvpn-devel-admin@lists.sourceforge.net, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Richard Mueller <mueller@...60...> said:

> Hello James,
> 
> Thursday, December 19, 2002, 3:59:16 PM, you wrote:
> 
> JY> * How is --peerinit different from --ipchange?
> Good question. None. sh*t Please see below. :)
> 
> JY> * Shouldn't
> JY>   if ( !(signal_received == SIGUSR1 && !options->sigusr1_script ) )
> JY>    ...
> JY> be
> JY>   if (signal_received == SIGUSR1 && options->sigusr1_script)
> JY>    ...
> JY> ?
> d*mn. yes. this is the sprit of "cut'n'paste" coding. Think I pasted
> the condition some lines above.
> 
> I wrote it short afer visiting "Lord of the Rings II" and a 18h
> workday without any coffee (I am allergic).

Hey, that's an interesting excuse...  Tolkien had a great sense of foreboding
about the advancing march of technology and industrialization and he would
probably have taken some pleasure in knowing that his storyweaving would throw
a wrench into the workings of someone's machinery...  not to mention being
under the influence of a lack of caffeine :)

> So sorry for the bad code, I won't do it again. ;-(
> I took the conclusion for me:
> $ patch && test && sleep && test && submit
> 
> 
> JY> The failover idea is interesting.
> It works quite good in my enviroment here (even better after fixing the
> patch ;) ).
> 
> - If openvpn is stopped on both sides, the alternative route is taken
>   immediateley.
> 
> - If the link between the two tun-endpoints breaks it takes as long
--ping-restart.
>   The prefered route is taken immediateley when the tunnel returns.

So it looks like all we need is a --sigusr1-script option.  That seems pretty
reasonable.  After you've tested it somewhat, would you mind writing an entry
for the HOWTO that explains how to use the ipchange and sigusr1 scripts to set
up a failover configuration?  Probably just a restatement of what you've
described in your emails, but maybe with a bit more detail such as how to set
up the Linux Advanced Routing component of the setup.  I think people would
find it very useful, and this is certainly a case where the code itself (i.e.
the script patch) is fairly trivial but the documentation on how to do it is
the far more essential component.

Thanks,
James

> 
> 
> Best regards and sorry again for the bad code,
> 
> Richard Mueller
> 



-- 




