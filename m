References: <20200812140120.21287-1-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <80bc3b8e-5fc3-c3a9-bb8e-2fd35e84f7d9@...277...>
Date: Wed, 12 Aug 2020 15:40:14 +0100
MIME-Version: 1.0
In-Reply-To: <20200812140120.21287-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Refactor
 key_state_export_keying_material functions
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
To: openvpn-devel@lists.sourceforge.net

typo

On 12/08/2020 15:01, Arne Schwabe wrote:
> This refactors the common code between mbed SSL and OpenSSL into
> export_user_keying_material and also prepares the backend functions
> to export more than one key.
> 
> Also fix checking the return value of SSL_export_keying_material
> only 1 is a sucess, -1 is also an error.

sucess -> success


