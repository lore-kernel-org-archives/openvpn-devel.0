MIME-Version: 1.0
In-Reply-To: <20141127142228.GA17158@...1296...>
References: <1416755831-21250-1-git-send-email-lstipakov@...277...>
	<20141127142228.GA17158@...1296...>
Date: Thu, 27 Nov 2014 17:08:09 +0200
Message-ID: <CAGyAFMWeGMnuRObAkLeTZ4iMZE8xOH1QBtnS2FCeGqwRaCe1Bw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Peer-id patch v7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

Currently it should be safe, since multi_create_instance returns NULL
if amount of clients >= max_clients. In this case we won't reach that
"for" loop thanks to "if (mi)" check.

But it probably won't harm to assert if we've reached "for" loop and
could not find available "instance" item. I can implement that.

As for the second question - hard to say. If we make it opt-in, we
probably will need to announce this feature loudly to make users aware
of that. From the other side, it is not inconceivable to assume that
someone might not want this. Maybe we could make it opt-out and have
"-no-peer-id" config option?

-Lev

2014-11-27 16:22 GMT+02:00 Gert Doering <gert@...1296...>:
> Hi,
>
> On Sun, Nov 23, 2014 at 05:17:11PM +0200, Lev Stipakov wrote:
>> Changes in v7:
>> A few nitpicks.
>
> Went in, and has just been pushed.  Time for your dance now :-)
>
> Question to you:
>
>> @@ -75,6 +101,16 @@ multi_get_create_instance_udp (struct multi_context *m)
>>                   {
>>                     hash_add_fast (hash, bucket, &mi->real, hv, mi);
>>                     mi->did_real_hash = true;
>> +
>> +                   for (i = 0; i < m->max_clients; ++i)
>> +                     {
>> +                       if (!m->instances[i])
>> +                         {
>> +                           mi->context.c2.tls_multi->peer_id = i;
>> +                           m->instances[i] = mi;
>> +                           break;
>> +                         }
>> +                     }
>
> Is this code "safe"?  That is, if max_clients is set too low, and you have
> more than this number of clients trying to connect, what will happen?
>
> Will the server check this case before this loop, or will it just "not
> find a free instance" and leave peer_id as "0"?
>
> Maybe we should add an ASSERT() here, to be sure that whatever other pieces
> of the code do, this will always end up in a defined state  (as a separate
> patch).
>
>
>
> Second, question to the group.  Right now, this code is active unconditionally
> on the server side - what if someone does not want this behaviour, for
> whatever reason?  Shall we make it depend on --float (which right now
> doesn't do anything for a --server OpenVPN server)?
>
> This should be a fairly small change, I think, just never send the client
> a "peer-id <n>" push-reply (so it won't use T_PACKET_V2), and check
> "if (options.float)" before checking whether it's a floated client...
> so the question is more along the line "is this a useful thing to do,
> nor not?".
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...



-- 
-Lev

