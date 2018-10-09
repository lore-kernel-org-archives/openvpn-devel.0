References: <20181009113509.GH23034@...1152...>
 <3991f0b3-c985-e280-bd51-17177f8204d3@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9d36de63-29a5-a0d5-d024-0dbe825b1afe@...1227...>
Date: Tue, 9 Oct 2018 19:58:29 +0200
MIME-Version: 1.0
In-Reply-To: <3991f0b3-c985-e280-bd51-17177f8204d3@...1147...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [Openvpn-users] disabling compression on the
 fly?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>, Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>, openvpn-users@lists.sourceforge.net
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 09.10.18 um 14:34 schrieb Jan Just Keijser:
> Hi Ralf,
> 
> On 09/10/18 13:35, Ralf Hildebrandt wrote:
>> Currently we're suppling our user with a charite.ovpn File containing:
>>
>> ...
>> compress lzo
>> ...
>>
>> In some cases, we're overriding this on the server side by using:
>>
>> if (defined $ENV{'IV_LZ4'}) {
>>     $logger->info("$username lz4: available");
>>     push @outline, 'compress lz4';
>>     push @outline, 'push "compress lz4"';
>>     # push old style and new style options!
>> }
>>
>> Now a recent version of openvpn.connect on IOS (3.0.2) has broken
>> this, by disabling compression by default.
>>
>> My idea: Since the client config already enables framing for
>> compression, why not turn compression off - on the fly - for every
>> client?
>>
>> How would I push an "empty" compression parameter?
>> Is this feasible at all?
>>
> very interesting question...  and I had to dive into the source code to
> find the following:
> 
> 7420         VERIFY_PERMISSION(OPT_P_COMP);
> 7421         if (p[1])
> 7422         {
> 7423             if (streq(p[1], "stub"))
> 7424             {
> 7425                 options->comp.alg = COMP_ALG_STUB;
> 7426                 options->comp.flags =
> (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
> 7427             }
> 7428             else if (streq(p[1], "stub-v2"))
> 7429             {
> 7430                 options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
> 7431                 options->comp.flags = COMP_F_ADVERTISE_STUBS_ONLY;
> 7432             }
> 
> which means that if you would use
>   compress stub-v2
> then you'd basically end up with bogus compression - this does not seem
> to be documented and I have no idea what the main difference is between
> 'stub' and 'stub-v2'.
> 

stub-v2 is almost identical to no framing. It only add 0x50 0x?? (I
forgot what exactly) if the packet begins with 0x50 which would be IPv5)

so compress stub-v2 and push "compress stub-v2" is a good idea. See also
https://community.openvpn.net/openvpn/wiki/VORACLE

Arne

