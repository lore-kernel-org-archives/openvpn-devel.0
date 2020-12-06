References: <20201206145124.77fc2db6@...1661...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <37a818a1-f770-9cbd-26f5-c4fbbd86a166@...1227...>
Date: Sun, 6 Dec 2020 16:06:19 +0100
MIME-Version: 1.0
In-Reply-To: <20201206145124.77fc2db6@...1661...>
Subject: Re: [Openvpn-devel] Update client config over control channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Michael Kress <lists@...1660...>, openvpn-devel@lists.sourceforge.net


Am 06.12.2020 um 14:51 schrieb Michael Kress:
> Hi list,
>
> Problem: OpenVPN Clients have to be reconfigured from time to
> time because e.g.
> - CA certificate changed

> - client certificates/keys should get updated
Pusdhing that over the control channel only works in some environment.
> - client destination address to server should be changed
That is normally handled by DNS.
>
> For these and others eighter
> a) a human must take action and execute commands, store files etc.
> b) some external mechanism uses the existing data channel and triggers
>      services outside of OpenVPN. This means, that on client side
>      another process has to be started, which comes with complications
>      like addressing, privileges and so on.
>
> Could you imagine a mechanism in OpenVPN, where the control channel
> could be used for generic messages between server and client? This
> control channel would acts like a websocket, is encrypted and secure.
>
> A huge advantage to b) would be, that no external service has to exist
> on the client side and the addressing works via common name.
You talk here about a generic socket like mechansim but also want no 
external service. For openvpn itself implementing a socket like 
mechanism that isn't exposed to external programs doesn't make sense. 
For internal messages we can just use the control channel itself. And 
for external programs you can just use a normal socket+DNS after the VPN 
is established. The performance of the control channel is also not very 
good compared to modern TCP variants as it never needed to transfer more 
than a few kilobytes.
>
> Looking at check_incoming_control_channel_dowork() makes me think, if
> there could exist another PUSH_command that could be very generic and
> address code in a loaded plugin? Such a plugin could rewrite the local
> configuration file of the client.

For limited communiction we already have --echo and push-peer-info with 
UV_* variables.

> On server side one could fire up the management interface and initiate
> this PUSH command - similar to "kill cn", that causes the server to
> tell the client that it should disconnect.
>
> There is an architectural implication though: Secrets (like
> certificates) are transfered over the same transportation channel. Is
> this a huge DON'T in the art of crypto?
You are assuming a simple setup where openvpn doesn't drop privileges 
after reading the certifcates and private keys. And that there are even 
files. Setups can also have the key/files on smartcards or other 
external storage like Android/Ios keystore. And that config files can 
even managed by OpenVPN is also a big uncertainity.
>
> This won't be a 100% solution for everybody, e.g.
> - there is no config file, OpenVPN gets started via network manager
> - write privileges for config or key material is not granted
> - plugin is not there because the user installed a standard OpenVPN
>    packet
>
> This could help admins, that have to maintain a bigger VPN installation.

To be honest I don't see the target audience like you do. Big central 
adminstrated setup will use their existing management software for 
managing client configuration and small admin will want to avoid to 
setup a mechanism like this. Also you are assuming a trust model 
("client has ulimited trust of server") that is generally not there.

Also since we have script setup etc and openpvn is often run with 
evelated privileges, a config file can be used to gain these evalated 
privilges. So this mechanism will be a potential security problem.

And finally adding file management/config management feels like adding 
functionality to OpenVPN that is really outside its scope. I also not 
aware of any other TLS or certificate based protocol that offers 
anything like this.

Arne


