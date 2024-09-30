Message-ID: <09a9b61e-6660-33a9-e282-8cfbeb3ef34b@...2108...>
Date: Mon, 30 Sep 2024 12:35:39 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAOrkh=Vw_5rLO=Ny4RKMUfjVAhoAD36SyeZj0EjZfwnqHaL2QQ@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <CAOrkh=Vw_5rLO=Ny4RKMUfjVAhoAD36SyeZj0EjZfwnqHaL2QQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Configurable installation directories
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
To: Petr Portnov <mrjarviscraft@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 24/09/2024 15:26, Petr Portnov wrote:
> Hi there!
> Continuing the packaging of the latest OpenVPN-linux for NixOS, I would 
> like to propose the following addition to the build system.
> 
> What it does is it allows you to customize the installation paths for 
> DBus and systemd services and adds the option to disable the generation 
> of `openvpn3_statedir / 'configs'` directory (which is not always 
> desired, e.g. when the OS takes this responsibility).

That's again, Petr!

I'm going to pull this into the coming v24 release.  I'll keep you 
posted on the progress here.

Your changes makes sense, so I don't expect any issues here.  Going to 
test it a bit first, though.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



