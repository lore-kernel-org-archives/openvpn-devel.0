MIME-Version: 1.0
In-Reply-To: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
References: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Jul 2018 13:27:36 -0400
Message-ID: <CAKuzo_gNncm8R3LsAp7szVwpAFm5C7GjAuzX9JeyGkieq3cduQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to
 populate Windows VPN flyout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Kevin Kane <kkane@...2393...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Jul 25, 2018 at 1:01 PM, Kevin Kane via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
> From ed96e2d91a0eb9ecdaab8d7104f397f7d77e5ced Mon Sep 17 00:00:00 2001
>
> From: Kevin Kane <kkane@...2393...>
>
> Date: Fri, 13 Jul 2018 09:50:00 -0700
>
> Subject: Update system tray to populate Windows VPN flyout
>
>
>
> Add a DLL to be wired in as a custom dialer, which introduces new build
> dependencies
>
> Add copyright notices as required where Microsoft has contributed code
>
>
>
> Signed-off-by: Kevin Kane <kkane@...2393...>
>

As discussed in a previous thread, I'm not sure we should have this in
its current form:

(i) It adds and entry per config to network connections which will be
a nuisance for users who have far too many configs (there are some
users with 100's of config files) -- so we at least need an option to
enable/disable this.

(ii) This only supports connect, not disconnect and the entry does not
show whether its connected or not -- so this is a feature of very
dubious utility.

(iii) Communicating with the GUI using COPYDATA message (we support
connect, disconnect, status etc.) should be preferred over hard-coding
IDM_CONNECTMENU.

Selva

