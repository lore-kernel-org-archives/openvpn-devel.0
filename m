References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-5-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e5238798-6b45-2261-7196-dbac57ac0888@...2181...>
Date: Fri, 17 Sep 2021 11:53:43 +0200
MIME-Version: 1.0
In-Reply-To: <20210904095629.6273-5-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 4/7] do not include --cipher value in
 data-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

we discussed on IRC how to improve the Changes.rst and the manpage part
about --cipher. Here is the result:


Changes.rst:

    ``--cipher`` argument is no longer appended to ``--data-ciphers``
    by default. Data cipher negotiation has been introduced in 2.4.0
    and been significantly improved in 2.5.0. The implicit fallback
    to the cipher specified in ``--cipher`` has been removed.
    Effectively, ``--cipher`` is a no-op in TLS mode now, and will
    only have an effect in pre-shared-key mode (``--secret``).
    From now on ``--cipher`` should not be used in new configurations
    for TLS mode.
    Should backwards compatibility with older OpenVPN peers be
    required, please see the ``--compat-mode`` instead.

manpage:


--cipher alg
    This option should not be used any longer in TLS mode and still
    exists for two reasons:
        * compatibility with old configurations still carrying it
          around;
        * allow users connecting to OpenVPN peers older than 2.6.0
          to have ``--cipher`` configured the same way as the remote
          counterpart. This can avoid MTU/frame size warnings.
    Before 2.4.0, this option was used to select the cipher to be
    configured on the data channel, however, later versions usually
    ignored this directive in favour of a negotiated cipher.
    Starting with 2.6.0, this option is always ignored in TLS mode
    when it comes to configuring the cipher and will only control the
    cipher for ``--secret`` pre-shared-key mode (note: this mode is
    deprecated strictly not recommended).

    If you wish to specify the cipher to use on the data channel,
    please see ``--data-ciphers`` (for regular negotiation) and
    ``--data-ciphers-fallback`` (for a fallback option when the
    negotiation cannot take place because the other peer is old or
    has negotiation disabled).



I hope the formatting will not be messed up.
Gert offered to add this text to the patch while committing.

Regards,

-- 
Antonio Quartulli

