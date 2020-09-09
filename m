References: <20200908154157.13809-1-arne@...1227...>
 <f4128ade-e54c-00b4-0e16-c54e08ab0454@...2318...>
 <ea18a0ae-5512-ad24-ab13-48bfb8ef3a7b@...1227...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <a15ba93c-e908-7110-6b41-61b964ea436b@...2318...>
Date: Wed, 9 Sep 2020 10:04:13 +0200
MIME-Version: 1.0
In-Reply-To: <ea18a0ae-5512-ad24-ab13-48bfb8ef3a7b@...1227...>
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

On 9/8/20 6:38 PM, Arne Schwabe wrote:
> I really wonder which large deployment want to do that instead of a CA.
> I really understand the need for small and simple deployments. But for
> larger deployments a CA + CRL seems more useful for everything that I
> can come up with.

It would be more for the situation where you already have a "parallel 
trust", e.g. through an OAuth API where a CA would be redundant. Just 
having an API to register fingerprints (which would act as a CRL at the 
same time by simply removing fingerprints) is easier than having a 
complete CA with CRL.

Of course, all of this can also be done by using a CA, and something can 
be said that if you operate on that scale you can also handle the extra 
"cost" of a CA...

Thanks,
François

