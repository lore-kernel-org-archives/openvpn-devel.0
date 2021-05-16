References: <20200717171036.20687-1-davids@...515...>
 <6062d64c-14ef-0e0d-4e83-925b79b4900b@...1227...>
 <7030cf8b-d047-107d-21b8-f02c8a1338c9@...1227...>
 <77750051-9589-15db-34cb-3aacc8b69694@...2181...>
 <c120ccab-50b8-fc24-1edc-6229d2b75ac5@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a2007ed7-87ae-9445-17ef-643c6729c447@...1227...>
Date: Sun, 16 May 2021 19:14:04 +0200
MIME-Version: 1.0
In-Reply-To: <c120ccab-50b8-fc24-1edc-6229d2b75ac5@...1856...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Remove --no-replay
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net


> 
> Given 2, how clear is our timeline on sunsetting non-AEAD ciphers? That
> would automatically sunset --no-replay. (I've lost track a bit...)

Heated debate as that is equal to drop compatibility completely with
OpenVPN 2.3. We have already a heated debate if dropping 2.3 config
compatibility is possible or not (e.g. you need to add ciphers to
data-ciphers to still to connect to a 2.3 peer).

Arne

