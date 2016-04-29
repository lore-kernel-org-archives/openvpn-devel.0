References: <57239121.8000704@...277...> <57239518.9020503@...1227...>
	<5723B3A6.5030708@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5723E96F.7050403@...2080...>
Date: Sat, 30 Apr 2016 01:08:31 +0200
MIME-Version: 1.0
In-Reply-To: <5723B3A6.5030708@...277...>
Subject: Re: [Openvpn-devel] Artificial delays during connection setup
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Jiri Horky <jiri.horky@...277...>, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?B?SmnFmcOtIEphaG4=?= <jahn@...2025...>, =?UTF-8?B?xI0=?= <zubac@...2025...>, =?UTF-8?B?VsOtdCBIZcWZbWFu?= <herman@...2025...>

On 29/04/16 21:19, Jiri Horky wrote:
> Thanks for the quick response.
> 
> On 04/29/2016 07:08 PM, Arne Schwabe wrote:
>> Am 29.04.16 um 19:51 schrieb Jiri Horky:
>>> Hi list,
>>>
>>> I was wondering why the connection setup on Linux with openvpn 2.3.10
>>> takes about 2.5s even on local network and dig deeper in the code. It
>>> seems there are two places where an artificial delay of 1s is added.
>>>
>>> First one is waiting before checking the connection status is checked in
>>> src/openvpn/init.c
>>>
>>> 1108   if (!deferred)
>>> 1109   {
>>> 1110     /* initialize connection establishment timer */
>>> 1111     event_timeout_init (&c->c2.wait_for_connect, 1, now);
>>> 1112
>> I think nobody knows anymore why there is this timeout and without
>> proper testing/codereview just removing it might be a bit dangerous.
> At least on Linux, I checked that the client was doing completely
> nothing during this wait (no syscall, nor other activity). On
> Windows/Android, we need to check more.

It will also be needed to verify this from a server perspective as well.  I
see that do_init_timers() are also called via do_deferred_options() via
multi_connection_established() via multi_process_post() - from a very quick 30
seconds look at the code looks to be used on both client and server.


-- 
kind regards,

David Sommerseth

