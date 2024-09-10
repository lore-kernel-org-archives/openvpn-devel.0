Message-ID: <7e2afe85-6129-4813-b5b3-a4a82f685528@...1227...>
Date: Tue, 10 Sep 2024 23:48:44 +0200
MIME-Version: 1.0
References: <20240906103734.36633-1-frank@...2641...>
 <202409082041.488KfLeN094702@...2054...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <202409082041.488KfLeN094702@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Interpret --key and --cert
 option argument as URI
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
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net


> 
> Your patch has been applied to the master branch.
> 
> commit 3512e8d3ada4fa7d04925a89fd9f3669655c7887 (master)
> Author: Selva Nair
> Date:   Fri Sep 6 12:37:34 2024 +0200
> 
>       Interpret --key and --cert option argument as URI
> 
There is something wonky going on. On my local macOS build I am getting 
errors with this on master now:

openvpn --cert /Users/arne/ovpn/styx-secp.pem --key 
/Users/arne/ovpn/styx-secp.pem

2024-09-10 23:25:00 us=689075 OpenSSL: error:1608010C:STORE 
routines::unsupported:
2024-09-10 23:25:00 us=689082 Cannot load certificate from URI 
</Users/arne/ovpn/styx-secp.pem>


styx-secp.pem is a file that contains both cert and key:

-----BEGIN PRIVATE KEY-----
[...]
-----END PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
[...]
-----END CERTIFICATE-----

The same combined key/cert file works fine with the patch again reverted 
and also if I split the file into key and cert file. I haven't looked 
why it fails but I think we need to restore that functionality again.

Arne

