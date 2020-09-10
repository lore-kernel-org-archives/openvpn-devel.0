MIME-Version: 1.0
References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
 <20200829194728.GU75094@...1296...>
 <CAAWBBYM+8YfP9-nwAsPYM806CzQXoy_5d+9MLkfyGPatE3BTAQ@...278...>
 <20200830120703.GV75094@...1296...>
 <20200830203720.GX75094@...1296...>
 <CAAWBBYMnFOBo4pp_iZ-KnYu7pHbiLqYQJ3rKO1RF+yXcvivgYg@...278...>
 <20200831132357.GZ75094@...1296...>
 <CAAWBBYNLPWmjJ3whY6FAj2G8tT_qkPWZR-gUsKFHe1memta2Og@...278...>
 <CAAF3xa8T=mmZUQdyF3=AZMZZf46TJ85zH=WwAm7ORZiiGGWqZg@...278...>
 <CAKuzo_iTQWBA3t=to4sKdt21pxotNECVfTMFP_fhrEeQ3ejnQQ@...278...>
 <CAAF3xa_Jz1bjw52zBLLdXjgMymk8q+47kt9R8bP8K9Fpt8+s3g@...278...>
 <CAKuzo_jj0SXCVLrthzeCJddK2iKKXAAg4SGTA_pNRXYqcJfTQw@...278...>
 <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
 <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
 <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
In-Reply-To: <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 10 Sep 2020 10:38:41 +0300
Message-ID: <CAGyAFMV8JUUO7U3cgKGC-gVC2mqBTrtbFFbM8ATSAk+nO2hsMw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
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
To: Marvin Adeff <volleynbike@...277...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Marvin,

> 1.  I installed the beta3 msi from the web site logged in as a user that has admin privileges.  But no elevation was used to install it, just double-click on the file.
> 2.  I only used the GUI as installed, with no elevation, to start OpenVPN.
> 3.  With TAP selected in my .ovpn config file, everything works normally.
> 4.  I am reporting that (from the same login) if I change the .ovpn to use wintun (all edits done through the GUI selection), it fails with the error I showed below.

This doesn't look right. Could you provide a relevant part of a log
file? For example, below is my recent connection log with beta3 and
wintun:

2020-09-10 10:27:05 interactive service msg_channel=584
2020-09-10 10:27:05 ROUTE_GATEWAY 100.64.0.1/255.240.0.0 I=20
HWADDR=84:fd:d1:e8:1e:6c
2020-09-10 10:27:05 open_tun
2020-09-10 10:27:05 Ring buffers registered via service
2020-09-10 10:27:05 wintun device [OpenVPN Wintun] opened

The first line means the openvpn-gui uses interactive service, which
is used to open wintun device (which requires SYSTEM privileges)
and setting up tun interface (which requires elevated privileges).

Symptomes you mentioned are the same when GUI is run under elevated
privileges and interactive service is not used, but
it is impossible to say if this is the case without seeing logs.

