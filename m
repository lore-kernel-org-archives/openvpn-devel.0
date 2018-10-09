References: <20181009113509.GH23034@...1152...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <3991f0b3-c985-e280-bd51-17177f8204d3@...1147...>
Date: Tue, 9 Oct 2018 14:34:49 +0200
MIME-Version: 1.0
In-Reply-To: <20181009113509.GH23034@...1152...>
Content-Language: nl-NL
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>, openvpn-users@lists.sourceforge.net
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Ralf,

On 09/10/18 13:35, Ralf Hildebrandt wrote:
> Currently we're suppling our user with a charite.ovpn File containing:
>
> ...
> compress lzo
> ...
>
> In some cases, we're overriding this on the server side by using:
>
> if (defined $ENV{'IV_LZ4'}) {
>     $logger->info("$username lz4: available");
>     push @outline, 'compress lz4';
>     push @outline, 'push "compress lz4"';
>     # push old style and new style options!
> }
>
> Now a recent version of openvpn.connect on IOS (3.0.2) has broken
> this, by disabling compression by default.
>
> My idea: Since the client config already enables framing for
> compression, why not turn compression off - on the fly - for every
> client?
>
> How would I push an "empty" compression parameter?
> Is this feasible at all?
>
very interesting question...  and I had to dive into the source code to 
find the following:

7420         VERIFY_PERMISSION(OPT_P_COMP);
7421         if (p[1])
7422         {
7423             if (streq(p[1], "stub"))
7424             {
7425                 options->comp.alg = COMP_ALG_STUB;
7426                 options->comp.flags = 
(COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
7427             }
7428             else if (streq(p[1], "stub-v2"))
7429             {
7430                 options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
7431                 options->comp.flags = COMP_F_ADVERTISE_STUBS_ONLY;
7432             }

which means that if you would use
   compress stub-v2
then you'd basically end up with bogus compression - this does not seem 
to be documented and I have no idea what the main difference is between 
'stub' and 'stub-v2'.

YMMV,

JJK



