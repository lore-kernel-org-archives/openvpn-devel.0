Message-ID: <4E1401B6.9000208@...1114...>
Date: Wed, 06 Jul 2011 08:33:26 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4E01A5DB.4050808@...1114...>
	<1308731642-27020-1-git-send-email-dejong@...1435...>
In-Reply-To: <1308731642-27020-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 9/9] Moved doxygen-specific files to a
 separate directory
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/06/11 10:34, Adriaan de Jong wrote:
> ---
>  doc_compression.h                  |   92 ------------
>  doc_control_processor.h            |  189 ------------------------
>  doc_control_tls.h                  |  105 --------------
>  doc_data_control.h                 |  103 -------------
>  doc_data_crypto.h                  |   75 ----------
>  doc_eventloop.h                    |   67 ---------
>  doc_external_multiplexer.h         |   46 ------
>  doc_fragmentation.h                |   96 ------------
>  doc_internal_multiplexer.h         |   44 ------
>  doc_key_generation.h               |  148 -------------------
>  doc_mainpage.h                     |  162 ---------------------
>  doc_memory_management.h            |   99 -------------
>  doc_protocol_overview.h            |  199 -------------------------
>  doc_reliable.h                     |   49 -------
>  doc_tunnel_state.h                 |  155 --------------------
>  doxygen/doc_compression.h          |   92 ++++++++++++
>  doxygen/doc_control_processor.h    |  189 ++++++++++++++++++++++++
>  doxygen/doc_control_tls.h          |  105 ++++++++++++++
>  doxygen/doc_data_control.h         |  103 +++++++++++++
>  doxygen/doc_data_crypto.h          |   75 ++++++++++
>  doxygen/doc_eventloop.h            |   67 +++++++++
>  doxygen/doc_external_multiplexer.h |   46 ++++++
>  doxygen/doc_fragmentation.h        |   96 ++++++++++++
>  doxygen/doc_internal_multiplexer.h |   44 ++++++
>  doxygen/doc_key_generation.h       |  148 +++++++++++++++++++
>  doxygen/doc_mainpage.h             |  162 +++++++++++++++++++++
>  doxygen/doc_memory_management.h    |   99 +++++++++++++
>  doxygen/doc_protocol_overview.h    |  199 +++++++++++++++++++++++++
>  doxygen/doc_reliable.h             |   49 +++++++
>  doxygen/doc_tunnel_state.h         |  155 ++++++++++++++++++++
>  doxygen/openvpn.doxyfile           |  279 ++++++++++++++++++++++++++++++++++++
>  openvpn.doxyfile                   |  279 ------------------------------------
>  32 files changed, 1908 insertions(+), 1908 deletions(-)
>  delete mode 100644 doc_compression.h
>  delete mode 100644 doc_control_processor.h
>  delete mode 100644 doc_control_tls.h
>  delete mode 100644 doc_data_control.h
>  delete mode 100644 doc_data_crypto.h
>  delete mode 100644 doc_eventloop.h
>  delete mode 100644 doc_external_multiplexer.h
>  delete mode 100644 doc_fragmentation.h
>  delete mode 100644 doc_internal_multiplexer.h
>  delete mode 100644 doc_key_generation.h
>  delete mode 100644 doc_mainpage.h
>  delete mode 100644 doc_memory_management.h
>  delete mode 100644 doc_protocol_overview.h
>  delete mode 100644 doc_reliable.h
>  delete mode 100644 doc_tunnel_state.h
>  create mode 100644 doxygen/doc_compression.h
>  create mode 100644 doxygen/doc_control_processor.h
>  create mode 100644 doxygen/doc_control_tls.h
>  create mode 100644 doxygen/doc_data_control.h
>  create mode 100644 doxygen/doc_data_crypto.h
>  create mode 100644 doxygen/doc_eventloop.h
>  create mode 100644 doxygen/doc_external_multiplexer.h
>  create mode 100644 doxygen/doc_fragmentation.h
>  create mode 100644 doxygen/doc_internal_multiplexer.h
>  create mode 100644 doxygen/doc_key_generation.h
>  create mode 100644 doxygen/doc_mainpage.h
>  create mode 100644 doxygen/doc_memory_management.h
>  create mode 100644 doxygen/doc_protocol_overview.h
>  create mode 100644 doxygen/doc_reliable.h
>  create mode 100644 doxygen/doc_tunnel_state.h
>  create mode 100644 doxygen/openvpn.doxyfile
>  delete mode 100644 openvpn.doxyfile

As this is a pure file move, moving all doc files into doxygen, this gets
an ACK.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4UAbYACgkQDC186MBRfrqPDgCeNR+nsdEQiDo0eZ4nX5Gd+KTQ
LZQAn3bCrGK+rrU6FtdwGHct5DIcInlm
=pyM5
-----END PGP SIGNATURE-----

