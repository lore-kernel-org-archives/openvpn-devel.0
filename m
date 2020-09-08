References: <20200908154157.13809-1-arne@...1227...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <f4128ade-e54c-00b4-0e16-c54e08ab0454@...2318...>
Date: Tue, 8 Sep 2020 18:10:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200908154157.13809-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 0/4] Allow setting up OpenVPN in TLS
 mode without CA
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 9/8/20 5:41 PM, Arne Schwabe wrote:
> The main difference of this patch set to Jason's V1 version is that it does
> not rely on an external script on the server side and instead relys on an a
> inlined <peer-fingerprint> section. The downside is that this requires a
> server restart on adding a client but the upside is that no script-security
> or external scripts are necessary and server/client setup become symmetric.

One of the nice features of Jason's patch was that also for big(ger) 
deployments you could get rid of the CA if you have another channel to 
establish trust between client and server.

I guess it won't be possible to use --tls-verify (on the server) with 
your patch and verify the fingerprint(s) there? For the client it is 
enough to have a (fixed) list of trusted fingerprints. Would it be 
possible to add this (again)?

Regards,
François

