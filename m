References: <a32b8037-2e77-ac39-fc2e-05ff6f0c4b97@...1147...>
 <0b595687-c79d-e95e-fc0c-adfe226e15c2@...1227...>
 <6f34b68c-5588-bc0e-65ef-993e044e7cc6@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e25b933f-ac86-dae2-cc06-de668d01a854@...1227...>
Date: Fri, 4 Dec 2020 17:18:50 +0100
MIME-Version: 1.0
In-Reply-To: <6f34b68c-5588-bc0e-65ef-993e044e7cc6@...1147...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] weird issue with server failover when *Not*
 using keepalive
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> This code path is present from 2.1 on, in more or less unaltered form....

Yes but only used for profiles with <connection>. For version before
that profiles with only --remote entries used a different (now removed)
code path.

Arne



