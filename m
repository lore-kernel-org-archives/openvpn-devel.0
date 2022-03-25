Message-ID: <889af1a8-eee2-d869-00ef-29ada1db2bb6@...1227...>
Date: Fri, 25 Mar 2022 16:04:21 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <400a4652-39d6-ec8d-6f58-824f552e0440@...2666...>
 <9f710eb5-007c-cc8e-56b0-1b00c3f12c19@...1227...>
 <1315401d-b450-6db4-08f5-fed79f51a205@...2666...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <1315401d-b450-6db4-08f5-fed79f51a205@...2666...>
Subject: Re: [Openvpn-devel] [PATCH] Enablement of quantum-safe key
 establishment
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
To: Michael Baentsch <info@...2666...>, openvpn-devel@lists.sourceforge.net

Am 25.03.22 um 08:21 schrieb Michael Baentsch:
> Thanks very much for the quick and thorough feedback. Indeed your last 
> question is pivotal making the patch _much_ simpler (attached): The 
> problem manifests itself only in the presence of providers introduced in 
> OpenSSL3.0. At the same time, the curve name causing the "dance code" is 
> permitted as of OpenSSL3.0...
> 
> So all other observations below are moot/should be resolved with the 
> much simpler new patch attached. Feel free to delete/amend the comment 
> changes as you see fit.

Thanks v2 looks much better code wise and gets ack from me. To commit 
the patch could you either send the patch in git format-message format 
or provide a commit subject and text so we can make full commit of your 
patch?

Arne

