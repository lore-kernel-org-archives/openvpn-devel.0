MIME-Version: 1.0
In-Reply-To: <20151109205639.GL24952@...1296...>
References: <56404FD0.9060100@...515...>
	<1447101323-1727-1-git-send-email-selva.nair@...277...>
	<20151109205639.GL24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 9 Nov 2015 16:15:58 -0500
Message-ID: <CAKuzo_h_kpVhpaa9AyrEO=0+7tdAk9Mk+LgPAQ7zvk0Uym_XqQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH for gui] Do not disconnect on suspend by
	default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

>> Requires the installer to update the registry during an upgrade of exisitng
>> installations, or notify the end user of the change in the default value of
>> disconnect_on_suspend (0).
>
> What does this patch *do*?  Is this the "set up registry key on first
> start" part (so we set the default differently now)?
>
> But that implies that an upgrade will not change the default, right?

You are right, the current openvpn installer does not rewrite the
registry for the GUI, so an update does not change the default and
that is not good. I left that to the package maintainer with that
comment about the installer and upgrading.

I would have preferred to completely remove the handling of
PBT_APMSUSPEND event in main.c but did not wanted to make pervasive
changes..

Instead, one could just modify openvpn.nsi with an added line in the
GUI install section:

DelRegKeyIfUnchanged HKLM
"SOFTWARE\${PACKAGE_NAME}_GUI}\disconnect_on_suspend" "1"


Selva

