Date: Tue, 12 Aug 2014 11:26:42 +0300 (EEST)
From: Heikki Hannikainen <hessu@...1822...>
In-Reply-To: <53BD10EB.9010509@...1227...>
Message-ID: <alpine.DEB.2.02.1408121108120.3669@...1831...>
References: <CAGyAFMXhPTamN5tZYr92=re8Bhxky=priWS8UhCU3E_p2D8-mQ@...278...>
	<CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>
	<53B03B43.2040009@...1227...> <53BD10EB.9010509@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] session-id implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 9 Jul 2014, Arne Schwabe wrote:

> Am 29.06.14 18:13, schrieb Arne Schwabe:
>> Am 27.03.14 09:57, schrieb Lev Stipakov:
>>> Hi,
>>>
>>> Same patch with added NULL check in push.c:308. Turns out that
>>> peer_info might be NULL.
>>>
>> I looked at the patched, a few minor nitpicks:

One more little nitpick:

   uint32_t sess;

    ...

   sess = ((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) | (multi->vpn_session_id << 8);
   ASSERT (buf_write_prepend (buf, &sess, 4));

I think this will cause byte sex issues when talking between big and 
little endian machines.

A strategically placed htonl() + ntohl() pair might help.  Have to make 
sure that the opcode really goes in as the first byte on the wire, and 
that the next 3 bytes are the 3 least significant bytes of the session ID.

   uint32_t sess = htonl(
     (((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24)
     | (multi->vpn_session_id & 0xFFFFFF)
   );
   ASSERT (buf_write_prepend (buf, &sess, 4));

Right? Maybe? :)

I suppose this patch will improve things quite a bit for mobile clients 
which switch from network to another.

   - Hessu


