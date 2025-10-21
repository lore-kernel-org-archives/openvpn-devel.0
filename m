Message-ID: <38497401-3a75-4885-8d0f-349c837d14a2@...1227...>
Date: Tue, 21 Oct 2025 22:34:21 +0200
MIME-Version: 1.0
References: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
 <aPfhwvsB8Sk27GME@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <aPfhwvsB8Sk27GME@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] tcp: apply CLOEXEC to accepted socket,
 not listener
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Joshua Rogers <contact@...2949...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


Am 21.10.2025 um 21:40 schrieb Gert Doering:
> Hi,
>
> On Tue, Oct 21, 2025 at 06:11:06PM +0000, Joshua Rogers via Openvpn-devel wrote:
>> The accept path calls set_cloexec(sd) after accept(). That re-flags the
>> listening socket, which is already CLOEXEC from create_socket_tcp(), and
>> leaves new_sd inheritable. As a result, client-connect and auth scripts
>> spawned after accept can inherit the connected socket and read or write
>> the raw TCP stream. This defeats the stated intent to prevent scripts from
>> accessing the client socket.
> Impressive find.  I had to actually look at the code to see what
> you are talking about :-)
>
> So we do
>
>          new_sd = accept(sd, &act->dest.addr.sa, &remote_len);
>
> and then
>
>          /* set socket file descriptor to not pass across execs, so that
>           * scripts don't have access to it */
>          set_cloexec(sd);
>
Before commiting we have to check that port-share does not rely on this 
behaviour to pass the fd the forked instances. I didn't check right now.

Arne


