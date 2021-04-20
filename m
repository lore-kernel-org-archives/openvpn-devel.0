References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <604ed27d-c1e1-e862-f471-c3d15f05097b@...2181...>
Date: Tue, 20 Apr 2021 18:14:48 +0200
MIME-Version: 1.0
In-Reply-To: <20210408140229.31824-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3] Change
 options->data_channel_use_ekm to flags
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/04/2021 16:02, Arne Schwabe wrote:
> Instead maintaining two different representation of the data channel
> options in struct options and struct tls_options, use the same
> flags variable that tls_options uses.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

It's a simple restyling, converting this flag to bitfield.
I don't think there is much gain, but allows adding more flags in the
future with little effort (and little chance to introduce bugs).

Passes my basic test (with the ekm being properly activated).

GitLab CI compile rig is happy too.

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

