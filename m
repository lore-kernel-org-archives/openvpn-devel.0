Message-ID: <1c9810cd-b2d5-eba4-70d4-4bc4a8e79479@...1227...>
Date: Fri, 10 Feb 2023 10:55:48 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230209142248.455120-1-arne@...1227...>
 <CAGyAFMUP-uCrCbQB2u6dOX-MczORL1nmyo9AS5scmTtws6d0Xg@...278...>
 <9b7d0e7b-912d-3daf-db02-8fc99d4f2a43@...1227...>
 <CAGyAFMWQbsMbEZw=SoG9RXrN_FFDWS5nSKyX6UKB=dVhphqe0Q@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAGyAFMWQbsMbEZw=SoG9RXrN_FFDWS5nSKyX6UKB=dVhphqe0Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add 'allow-compression stub-only
 and refuse framing with 'allow-compression no'
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 10.02.23 um 10:02 schrieb Lev Stipakov:
>> We can certainly add logic that will make the
>> client abort in this cases but that should affect all the other options
>> that are being pushed that the client refuses.
> 
> At least for compression we know for sure that the tunnel will be broken,
> doesn't it warrant any special case? At least clear log message "you connection
> will be broken for sure, but we haven't added logic to not to
> establish it at all just yet"
> 
> Moreover, with this patch broken VPN providers become even more broken - before
> one could add "disable-dco" and have a working tunnel with compression framing.
> Right now the behavior is consistently broken with/without dco - which
> is expected,
> but do we really want to add broken cases?
> 

To be honest, I have little sympathy for these VPN providers. Just 
because most OpenVPN 2.5.0 and earlier would accept pushing compression 
does not make that correct behaviour. And having no comp-lzo in your 
config but pushing "comp-lzo no" is pretty non-standard behaviour. I 
never seen that kind of thing before apart from deliberate testing. 
OpenVPN AS will also do that stuff but it will check your IV_COMP_* 
variables before pushing.

  If we want to make it easier for users to workaround these broken VPN 
providers, we might want to highlight compat-mode more in UI etc. E.g. 
having a dropdown/checkbox in OpenVPN GUI that allows picking 
compat-mode 2.5.0/2.4.0/2.3.6/2.3.0

Arne

