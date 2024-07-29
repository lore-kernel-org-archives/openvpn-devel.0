Message-ID: <dc55ebad-46c2-448c-89df-8e65d06e767e@...1823...>
Date: Mon, 29 Jul 2024 11:23:28 +0400
MIME-Version: 1.0
Content-Language: en-US
References: <6f899681-6de7-4fce-ae92-697d47d0f8d4@...1823...>
From: Dmitry Melekhov <dm@...1823...>
In-Reply-To: <6f899681-6de7-4fce-ae92-697d47d0f8d4@...1823...>
Subject: Re: [Openvpn-devel] windows client tests needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


Hello!



Hope we are not too late .
We jist tested block-local using this client in Windows 10 Pro 22H2

and do not see any difference in behaviour comparing with 2.6.

Thank you!




>>>> 06.06.2024 16:23, Gert Doering пишет:
>>>>> Hi,
>>>>>
>>>>> we have new code in master that helps with the "TunnelCrack" and
>>>>> "TunnelVision" attacks, that is, packets intended to go into the
>>>>> VPN being leaked away by means of a malicious DHCP server (= routing
>>>>> points outside the tunnel, so packets never hit OpenVPN).
>>>>>
>>>>> We used to have
>>>>>
>>>>>    block-outside-dns
>>>>>
>>>>> to prevent Windows from doing DNS lookups "around the VPN" - the main
>>>>> intent of this was "make sure split DNS works", but a side effect has
>>>>> also been "avoid DNS leaks".
>>>>>
>>>>> Heiko has now extended this code to be able to "block everything not
>>>>> going into the VPN".  To activate this, you need
>>>>>
>>>>>    redirect-gateway def1 block-local
>>>>>
>>>>> in your config ("block-local" is the keyword, but without "def1" you
>>>>> end up with a split-tunnel and "nothing else is allowed", which is 
>>>>> rarely
>>>>> a really good combination).
>>>>>
>>>>> Repeat: if "redirect-gateway block-local" is active, NO packets leave
>>>>> via LAN/WiFi/... interfaces, except those sourced by the openvpn.exe
>>>>> process.  This is important for maximum privacy, especially if you
>>>>> roam into a network with an untrusted DHCP server.
>>>>>
>>>>>
>>>>> Now - this code has been merged into "git master", and installers
>>>>> are here:
>>>>>
>>>>> https://github.com/OpenVPN/openvpn-build/actions/runs/9391365526?pr=641 
>>>>>
>>>>>
>>>>> (bottom of the page, "Artifacts", .zip files with a .msi inside).
>>>>>
>>>>>
>>>>> I want to have this in 2.6 as well, as it's sort of important for 
>>>>> certain
>>>>> classes of users (and also VPN providers, offering this as a 
>>>>> service) - but
>>>>> I do not feel it has been tested enough yet.
>>>>>
>>>>> So: PLEASE test these windows installers, in all 3 variants
>>>>>
>>>>>   1.  <nothing special in the config>
>>>>>   2.  block-outside-dns
>>>>>       (DNS is blocked, everything else not routed into the VPN 
>>>>> tunnel - like
>>>>>       "your local printer" etc - still works)
>>>>>   3.  redirect-gateway def1 block-local
>>>>>       (ONLY VPN works)
>>>>>
>>>>> and report back to us.
>>>>>
>>>>> gert
>>>>>
>>>>>

