Message-ID: <2bb3487e-6762-40ea-b6ad-2622a879ca21@...2889...>
Date: Sun, 25 May 2025 22:27:56 +0200
MIME-Version: 1.0
References: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
 <20250507074438.1326755-1-walter.openvpn@...2889...>
 <eedcf175305a088df0eb7ec146dbe441.squirrel@...2890...>
 <f60dbf91-c2f8-495b-ba14-967e70629d1b@...1227...>
 <ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...>
 <8ba925a1-85c9-4274-a512-32dcec35b147@...1227...>
Content-Language: en-US, sv-SE, nl
From: Walter Doekes <walter.openvpn@...2889...>
In-Reply-To: <8ba925a1-85c9-4274-a512-32dcec35b147@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP
 right after connection setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Good. Your understanding of the situation is the same.

I did not yet make a reproducer config -- mostly because I don't think 
we're doing anything non-standard. But I did double check that latest 
2.6 is affected, tested both client and server.

And, I added some tracing code, and I observed the following:

>     else if (verdict == VERDICT_VALID_CONTROL_V1 || verdict == VERDICT_VALID_ACK_V1)
>     {   
>         /* ACK_V1 contains the peer id (our id) while CONTROL_V1 can but does not
>          * need to contain the peer id */
>         struct gc_arena gc = gc_new();
> 
>         bool ret = check_session_id_hmac(state, from, hmac, handwindow);
> 
>         const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
>         if (!ret)
>         {   
>             msg(D_MULTI_MEDIUM, "Packet with invalid or missing SID from %s", peer);
>         }
>         else
>         {   
>             msg(D_MULTI_DEBUG, "Valid packet with HMAC challenge from peer (%s), "
>                 "accepting new connection.", peer);
>             //ret = false; // setting false here makes all setup fail
>         }
>         gc_free(&gc);
> 
>         msg(D_MULTI_MEDIUM, "do_pre_decrypt_check: verdict %d (%d)", verdict, ret);
>         return ret;
>     }

This is the code that has the changed behaviour.

In the before situation, we had this:

> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -55,8 +55,10 @@ do_pre_decrypt_check(struct multi_context *m)
>  
>      if (verdict == VERDICT_INVALID || verdict == VERDICT_VALID_CONTROL_V1)
>      {
> +        msg(D_MULTI_MEDIUM, "do_pre_decrypt_check: verdict %d (false)", verdict);
>          return false;
>      }
> +    msg(D_MULTI_MEDIUM, "do_pre_decrypt_check: verdict %d (true)", verdict);
>      return true;
>  }
>  

<time> do_pre_decrypt_check: verdict 1 (false)
m->pending = (nil), float = 0 // in multi_process_incoming_link
<time> Float requested for peer 0 to EXTIP:PORT


In the after-situation, we have this:

<time> do_pre_decrypt_check: verdict 2 (1)
<time> MULTI: multi_create_instance called
...
m->pending = 0x5a36ce132f10, float = 0 // in multi_process_incoming_link
<time> Float requested for peer 0 to EXTIP:PORT


verdict is VERDICT_VALID_CONTROL_V1 in both cases (which changed from 1 
to 2 after b364711486dc6371ad2659a5aa190941136f4f04), and the 
do_pre_decrypt_check now returns TRUE.

That TRUE-result results in calls to multi_create_instance, and now we 
have that "mystery connection".


When I find more time, I'll debug some more. But this might shed some 
light on things for you.

As far as I understand, the packet with VERDICT_VALID_CONTROL_V1 verdict 
is now detected as a new valid connection setup. That creates a 
connection on the new IP. And then the float gets rejected.

Walter



On 23-05-2025 02:26, Arne Schwabe wrote:
>> Totally fair that you don't want to apply a patch that you don't
>> understand. I on the other hand do not see why you're unable to reproduce.
>>
>> The scenario is not at all complicated:
>>
>> - Two vpn servers;
>> - first vpn server pushes a default gateway;
>> - second vpn server pushes its external IP as net_gateway (*);
>> - second vpn server immediately sees the client float from one IP to another.
> 
> What I understand so far:
> 
> - so you connect to vpn 1 first and that is a normal VPN with a default 
> gateway and you get VPN1 IP
> 
> - Then via that VPN, you connect a 2nd VPN and you have as source the 
> VPN IP, so the 2nd VPN server only see the VPN1 IP.
> 
> - after connection is established, you  do the host route directly to 
> the server.
> 
> - 2nd VPN server sees a float from VPN1 IP to extern IP (EXTIP) of client
> 
> - Server refuses the float since there is already a not fully 
> established connection on EXTIP
> 
> What I don't understand where the this not fully established connection 
> should be coming from. That would mean that the server would have need 
> to have received a valid connection attempt from EXTIP that was never 
> established. And I do not understand from you explaination where that 
> happens.
> 
>> If you're unable to reproduce that, then:
>>
>> - Either you're using a vastly different version and it has been fixed
>> since then (but not something that landed in debian/bookworm or
>> ubuntu/noble, and I _think_ I did try latest 2.6 as well);
>> - or you're using different settings (udp; auth/tls-auth; dev-tun;
>> subnet-topology);
>> - or there is some unknown factor involved that neither of us can think or
>> right now.
>>
>> I will create a reproducer config so you can see the exact settings (apart
>> from the IP addresses).
>>
>> In the mean time, can you confirm that you understand the scenario or ask
>> for additional clarification?
> 
> I wrote again down what you basically told me and there is still this 
> mystery connection that blocks you. And there is no explaination why 
> this connection exist in the first place. You are fixing the sympton of 
> this ghost connection that blocks your float but from my perspective we 
> have not really established why it exists in the first place.
> 
> Arne
> 

