Message-ID: <53E39A16.7050502@...1147...>
Date: Thu, 07 Aug 2014 17:24:06 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4BFCDD75.60907@...453...>
	<4BFD02A2.206@...1294...>	<4BFFC9AC.4010402@...1928...>	<loom.20140804T220217-977@...171...>	<20140804203606.GJ1118@...1296...>	<53E01EB5.3080805@...1490...>	<20140805052731.GK1118@...1296...>	<CAOAgVpzB3SERUoWqVnGX1Rs+TjYtrUP+w8LvSB9JUAvb8hi-sg@...278...>	<20140806093453.GR1118@...1296...>	<53E21B9C.9080104@...1114...>	<20140806132046.GS1118@...1296...>	<CAL2Any2=KAoehRkQFhppVCNfD9xTmXVtOM2Xx99rah3zYQj7rw@...278...>	<CAA1AbxJpEdVB+gd6YWvZfio7gzutTdCnziNV_ERTracoWRzQRg@...278...>	<53E291BE.1030906@...1114...>	<CAOAgVpzN_9agVhBZfRFYLiEsSavL6xWqRPsPnpYVQwqe6xPpXw@...278...>	<53E34D50.2030503@...1114...>
	<CAOAgVpzRHJO7sCQWy_m94bXs+7ipXnoLLdx4Xt7vqE8zXz5fyg@...278...>
In-Reply-To: <CAOAgVpzRHJO7sCQWy_m94bXs+7ipXnoLLdx4Xt7vqE8zXz5fyg@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN and Multi-Core processor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>
Cc: OpenVPN developers <openvpn-devel@lists.sourceforge.net>

On 07/08/14 16:15, Les Mikesell wrote:
> On Thu, Aug 7, 2014 at 4:56 AM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> However, that is most likely less intrusive and complex than to
>> basically needing to re-write the event handler which schedules that
>> each client gets their "time slice" in OpenVPN.  OpenVPN's event
>> handling the only thing which makes OpenVPN tackle more clients at the
>> same time, inside the same process/thread.
> I don't see why you'd need to change that at all.  Let the parent
> process continue to handle all of the client connections, and just add
> a socket to the child process(es) into the event loop.  Then instead
> of recomputing the keys in the parent, send that work over the socket
> to the child, which, being a fork, already has the same event handler.
> I think the only extra complexity would be having to track 'work
> pending' connection states until the child returns the completed work.

If I were to add multi-core support to OpenVPN I would start with the 
Apache httpd 1.3 or 2.x code base (1.3 is simpler as it does not include 
apache's MPM stuff). Httpd + mod_ssl has already solved the issue of 
accepting multiple client connections and should/will have similar 
issues with key renegotation.

I would also opt for function handlers/pointers per connection - that 
way you could server both udp+tcp from a single server instance - the 
client connection entry element would then contain pointers to the right 
handlers for tcp, udp and possibly even tun or tap.

JM2CW,

JJK

>> The OpenVPN implementation is also quite different from your apache
>> pre-fork suggestion, where the connection to a web server is closed
>> after having served a simple request with limited amount of data.
> Agreed - I wouldn't have the child processes accept any connections.
> The similarity would only be in managing a pool of worker processes.
> But for simplicity consider just one forked child where you hand off
> rekeying.  You'd probably really want a pool of connections to
> workers, but even one would double the CPU power available and avoids
> the complexity of balancing a pool.
>
>> Likewise, if you have 100
>> clients connecting 10 times retrieving data in parallel, this also is
>> a stressful moment for the web-server.  This doesn't happen in
>> OpenVPN, because each client gets a "time slice" before OpenVPN serves
>> others again.
> Right, but if you keep that same logic but fork the process and push
> the packets that involve a lot of CPU work to a different instance you
> get time slices out of multiple CPUs instead of just one.
>
>> The complexity of implementing a pre-forked model would actually be
>> far more complex than the alternative.  And in addition, there is a
>> need for a SSL state manager, which keeps tracks of the SSL keying
>> material for each client, no matter which approach is used.  OpenVPN
>> does already have such a state manager, but it's fairly simple because
>> it only needs to process each request one client by one client.
> A forked copy would automatically have the same management code...
> And you'd have the option of either passing any needed state over the
> socket between processes or using explicitly shared memory and some
> sort of lock to arbitrate access- which you'd need with threads
> anyway.   There would be some extra overhead in passing things over
> the sockets, but you might have 2 to 32x the CPU power to do it.
>


