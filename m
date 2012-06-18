MIME-Version: 1.0
In-Reply-To: <4FDF71C5.7090103@...1227...>
References: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
	<4FDF71C5.7090103@...1227...>
Date: Mon, 18 Jun 2012 21:42:20 +0300
Message-ID: <CAOazyz2M+nx1j0eNhXs2zrJyyuOJtaHF+pEiEpmRTXAsCLogfw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [V2.4 0/4] tun cleanups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Jun 18, 2012 at 9:21 PM, Arne Schwabe <arne@...1227...> wrote:
> Am 12.05.12 21:31, schrieb Alon Bar-Lev:
>> Platform independent interface for tun provider.
>>
>> Split the long tun.c into platform specific files using
>> tun_engine interface.
>>
>> Functionality is the same.
>>
>> Maintenance will be much easier! new options, like stacking
>> several interfaces and delegate partial control to plugin.
>>
> I have looked at your patchset. It going in the right direction I think.

Thanks!
But as time goes by it becomes harder to rebase... and the 2.4 branch
is not created... so I don't know what is the future of this patchset.
Although I invested a lot of time in it and it has huge potential of
eliminating duplicate code from the code base. I think this is simple
enough to be in 2.3, but we had this discussion already.

> For "my platform" I would like to have/implement a persisent tun which
> works as follows:
>
> - proivde tun configuration including routes and ifconfig
> - open tun with the information
> - keep tun open
> - on reconect: compare new configuration with old configuration.
> =C2=A0- if nothing has changed keep the old tun
> =C2=A0- otherwise first open the new tun then close the old tun

From the Android discussion I thought that the best will be to write a
plugin "platform", delegate the ip configuration to the openvpn plugin
interface.

Then you can implement whatever logic you need, if I understand
correctly, delegate ip management to the UI.

> If we redesign the tun interface I would like to support this as well.
> Having this interface would also make implementing platform specific
> redirect-gateway and so easier. Also the redirect variant used by
> Android (binding a socket to an interface) could be implemented as a
> alternative.

I think this should also be done in the plugin, using an inherited
unix domain socket to pass the fd.
I explain this more at the Android thread if I remember correctly.

Thanks!
Alon.

