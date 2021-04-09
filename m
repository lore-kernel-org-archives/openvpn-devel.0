References: <20210409162846.GT976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c9aa3222-63c1-ae68-c1b1-67b427010df2@...1227...>
Date: Sat, 10 Apr 2021 01:42:29 +0200
MIME-Version: 1.0
In-Reply-To: <20210409162846.GT976@...1296...>
Subject: Re: [Openvpn-devel] make --persist-key always-on and remove "off"
 code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


Am 09.04.2021 um 18:28 schrieb Gert Doering:
> Hi,
>
> there was a big discussion on the IRC channel today about interactions
> between "--chroot" and "--persist-key" and how and when stuff is reloaded
> or not.
>
> Now, we all seem to agree that OpenVPN has way too many obscure options,
> so I propose to get rid of another one, namely --persist-key - and I
> suggest to make it permanently-active ("load the keys at startup, and
> then do not touch these files again").
>
> Unless someone explains to me in simple words what the benefit is of
> reloading the keys on every new outbound connection...  yes, you *could*
> put in a new key/cert/CA set while OpenVPN is active, and then trigger
> a SIGUSR1 restart, having it "seamlessly" move to new credentials...
>
> But...
>
> How many of you do that?  Instead of just calling "service openvpn restart"?
>
> I do not use --persist-key, but I still restart my services after fiddling
> with configs...

I am also for removing persist-key option (and ignore it if still 
present) and just always have the same behaviour. I can also not come up 
with a valid scenario where setting/not setting this option is making a 
real desirable difference.

Arne




