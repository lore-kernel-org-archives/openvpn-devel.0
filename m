References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1533735413-18505-1-git-send-email-steffan.karger@...1435...>
 <1533735413-18505-5-git-send-email-steffan.karger@...1435...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <539df3cb-ff8c-ff3c-5058-e3237892931b@...277...>
Date: Wed, 8 Aug 2018 17:06:28 +0100
MIME-Version: 1.0
In-Reply-To: <1533735413-18505-5-git-send-email-steffan.karger@...1435...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4 7/7] tls-crypt-v2: add script hook to
 verify metadata
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

Hi,

just a reminder about \- in openvpn.8
and one missing space

hope this helps :-)


On 08/08/18 14:36, Steffan Karger wrote:
> To allow rejecting incoming connections very early in the handshake,
> add a --tls-crypt-v2-verify option that allows administators to
> run an external command to verify the metadata from the client key.
> See doc/tls-crypt-v2.txt for more details.
> 
> Because of the extra dependencies, this requires adding a mock
> parse_line() to the tls-crypt unit tests.
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v3: rebase on curent master / v3 patch set
> v4: fix memory leak (metadata buffer was not free'd for tls_wrap_tmp)
> 
>   Changes.rst                               | 12 ++++++
>   doc/openvpn.8                             | 35 ++++++++++++++--

<snip>

>   
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 21e52a5..9843fd8 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5296,9 +5296,38 @@ If supplied, include the supplied
>   in the wrapped client key.  This metadata must be supplied in base64\-encoded
>   form.  The metadata must be at most 735 bytes long (980 bytes in base64).
>   
> -.B TODO
> -Metadata handling is not yet implemented.  This text will be updated by the
> -commit that introduces metadata handling.
> +If no metadata is supplied, OpenVPN will use a 64-bit unix timestamp
                                                     ^

> +representing the current time in UTC, encoded in network order, as metadata for
> +the generated key.
> +
> +Servers can use
> +.B \-\-tls\-crypt\-v2\-verify
> +to specify a metadata verification command.
> +.\"*********************************************************
> +.TP
> +.B \-\-tls\-crypt\-v2\-verify cmd
> +
> +Run command
> +.B cmd
> +to verify the metadata of the client-specific tls-crypt-v2 key of a connecting
                                        ^            ^     ^

> +client.  This allows server administrators to reject client connections, before
> +exposing the TLS stack (including the notoriously dangerous X.509 and ASN.1
> +stacks) to the connecting client.
> +
> +OpenVPN supplies the following env vars to the command:
> +.RS
> +.IP \[bu] 2
> +script_type is set to "tls-crypt-v2-verify"
                              ^     ^  ^

> +.IP \[bu]
> +metadata_type is set to "0" is the metadata was user supplied, or "1" if it's a
> +64-bit unix timestamp representing the key creation time.
      ^

> +.IP \[bu]
> +metadata_file contains the filename of a temporary file that contains the client
> +metadata.
> +.RE
> +
> +.IP
> +The command can reject the connection by exitingwith a non-zero exit code.
                                                    ^ space missing


>   .\"*********************************************************
>   .TP
>   .B \-\-askpass [file]


