References: <r2Oc8HU_6LoYR_UE522CC5CcNVDyYxI_Hm8eiO-Fb-4aPwW5bsVWVIr8nTaZxFIbBT0duI74wOE_CObRLoLNgdkzwHN3ua1qMe9upZIuu98=@protonmail.com>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ede88ace-b4d3-b330-d119-dc1c210f8228@...1227...>
Date: Mon, 24 May 2021 22:43:49 +0200
MIME-Version: 1.0
In-Reply-To: <r2Oc8HU_6LoYR_UE522CC5CcNVDyYxI_Hm8eiO-Fb-4aPwW5bsVWVIr8nTaZxFIbBT0duI74wOE_CObRLoLNgdkzwHN3ua1qMe9upZIuu98=@protonmail.com>
Subject: Re: [Openvpn-devel] --tls-verify runs twice for a single cert in
 Peer-fingerprint mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: tincantech <tincantech@...2282...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>


Am 24.05.2021 um 16:07 schrieb tincantech via Openvpn-devel:
> Hi,
>
> Is this expected ?

I might to check if it is even a good idea to allow tls-verify and other 
verify options together peer-fingerprint. (You could implement 
peer-fingerprint with tls-verify as well. Since we haven't published 2.6 
yet we might just make the combination very limited to avoid allowing 
all kind of crazy combinations and having to support those.


Arne


