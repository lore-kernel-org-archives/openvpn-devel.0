Message-ID: <599d55b0-f214-e114-408d-76ce19670ee7@...2181...>
Date: Mon, 19 Sep 2022 01:34:11 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <YydCIP5l0WwH5OX+@greenie.muc.de>
 <61a61f4a-a7e7-ad3b-a029-ce351c310a4a@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <61a61f4a-a7e7-ad3b-a029-ce351c310a4a@...1227...>
Subject: Re: [Openvpn-devel] --explicit-exit-notify and P2P mode (trac #1337)
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
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi,

On 19/09/2022 01:17, Arne Schwabe wrote:
> In our current state where inetd is no longer supported, this behaviour 
> to exit makes little sense and we should probably change the behaviour 
> to SIGUSR1.

I agree with the above.
Alternatively, we should just ignore in P2P mode, but I think SIGUSR1 is 
a cleaner handler.

Cheers,


-- 
Antonio Quartulli

