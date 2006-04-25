From: Eric Limpens <eric@...624...>
Subject: Re: [Openvpn-devel] Changing routes on the client
Message-ID: <20060425171727.6abb2a1b@...625...>
In-Reply-To: <20060425100020.18086c30@...625...>
References: <20060425100020.18086c30@...625...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Apr 25 08:19:10 2006
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Tue, 25 Apr 2006 10:00:20 +0200
Eric Limpens <eric@...624...> wrote:

> 
> 
> Hello, 
> 
>  I've made a (win32) app which (tries to) alter the routes on the
>  client using the 'up' statement.

<snip>

>  Is it possible, to add an option to the behaviour of the 'push
>  redirect-gateway' which takes care of the above? The current 'def1'
>  and 'local' options don't quite get the job done.

Digging thru the sources, I've found a more convenient way by adding a
new flag to the redirect-gateway option.
When set, it uses 'add_route3' to re-route all (local) traffic to the 
remote endpoint: 

add_route3(0xc08a0500, 0xffffff00, rl->spec.rmote_endpoint, tt, flags, es)

However the 2 first parameters should be determined by the os.. For
testing purposes I've hardcoded them, things work as expected.

My question: does anyone have pointers how to obtain the local-net and netmask?


Eric

