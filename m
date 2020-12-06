Date: Sun, 6 Dec 2020 17:09:16 +0100
From: Michael Kress <lists@...1660...>
Message-ID: <20201206170916.53031f6e@...1661...>
In-Reply-To: <37a818a1-f770-9cbd-26f5-c4fbbd86a166@...1227...>
References: <20201206145124.77fc2db6@...1661...>
 <37a818a1-f770-9cbd-26f5-c4fbbd86a166@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Update client config over control channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Am Sun, 6 Dec 2020 16:06:19 +0100
schrieb Arne Schwabe <arne@...1227...>:

> Am 06.12.2020 um 14:51 schrieb Michael Kress:
[..]
> > Looking at check_incoming_control_channel_dowork() makes me think,
> > if there could exist another PUSH_command that could be very
> > generic and address code in a loaded plugin? Such a plugin could
> > rewrite the local configuration file of the client.  
> 
> For limited communiction we already have --echo and push-peer-info
> with UV_* variables.

Hm, eventually this could be used.

[..]
> > This could help admins, that have to maintain a bigger VPN
> > installation.  
> 
> To be honest I don't see the target audience like you do. Big central 
> adminstrated setup will use their existing management software for 
> managing client configuration and small admin will want to avoid to 
> setup a mechanism like this. Also you are assuming a trust model 
> ("client has ulimited trust of server") that is generally not there.
> 
> Also since we have script setup etc and openpvn is often run with 
> evelated privileges, a config file can be used to gain these evalated 
> privilges. So this mechanism will be a potential security problem.
> 
> And finally adding file management/config management feels like
> adding functionality to OpenVPN that is really outside its scope. I
> also not aware of any other TLS or certificate based protocol that
> offers anything like this.

Yes, the Unix philosophy "one tool, one task" is a good one, that
this idea would compromise.

Thanks for your honesty and time! I won't follow that idea any longer.
Eventually my view was a tad too narrow.

-- 
Servus
  Michael

