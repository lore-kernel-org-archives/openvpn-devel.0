From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 22 Jun 2011 08:51:36 +0200
Message-ID: <1308725496-10620-9-git-send-email-dejong@...1435...>
In-Reply-To: <1308725496-10620-1-git-send-email-dejong@...1435...>
References: <1308725496-10620-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 8/8] Added main/control docs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 doc_control_processor.h    |  189 +++++++++++++++++++++++++++++++++++++++++
 doc_data_control.h         |  103 +++++++++++++++++++++++
 doc_eventloop.h            |   67 +++++++++++++++
 doc_external_multiplexer.h |   46 ++++++++++
 doc_internal_multiplexer.h |   44 ++++++++++
 doc_mainpage.h             |  162 +++++++++++++++++++++++++++++++++++
 doc_protocol_overview.h    |  199 ++++++++++++++++++++++++++++++++++++++++++++
 doc_tunnel_state.h         |  155 ++++++++++++++++++++++++++++++++++
 forward.h                  |  163 +++++++++++++++++++++++++++++++++++-
 mtcp.h                     |    9 ++
 mtu.h                      |   68 ++++++++-------
 mudp.c                     |   14 +++-
 mudp.h                     |   29 +++++++
 multi.h                    |  161 ++++++++++++++++++++++++++++++++----
 openvpn.c                  |   31 +++++++
 openvpn.h                  |  153 ++++++++++++++++++++--------------
 16 files changed, 1476 insertions(+), 117 deletions(-)
 create mode 100644 doc_control_processor.h
 create mode 100644 doc_data_control.h
 create mode 100644 doc_eventloop.h
 create mode 100644 doc_external_multiplexer.h
 create mode 100644 doc_internal_multiplexer.h
 create mode 100644 doc_mainpage.h
 create mode 100644 doc_protocol_overview.h
 create mode 100644 doc_tunnel_state.h

diff --git a/doc_control_processor.h b/doc_control_processor.h
new file mode 100644
index 0000000..506f8ab
--- /dev/null
+++ b/doc_control_processor.h
@@ -0,0 +1,189 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file
+ * Control Channel Processor module documentation file.
+ */
+
+/**
+ * @defgroup control_processor Control Channel Processor module
+ * 
+ * This module controls the setup and maintenance of VPN tunnels and the
+ * associated security parameters.
+ * 
+ * @par This module's role
+ * The Control Channel Processor module lies at the core of OpenVPN's
+ * activities.  It handles the setup of new VPN tunnels, the negotiation
+ * of data channel security parameters, the managing of active VPN
+ * tunnels, and finally the cleanup of expired VPN tunnels.
+ * 
+ * @par State structures
+ * A large amount of VPN tunnel state information must be stored within an
+ * OpenVPN process.  A wide variety of container structures are used by
+ * this module for that purpose.  Several of these structures are listed
+ * below, and the function of the first three VPN tunnel state containers
+ * is described in more detail later.
+ *  - VPN tunnel state containers:
+ *     - \c tls_multi, security parameter state for a single VPN tunnel.
+ *       Contains three instances of the \c tls_session structure.
+ *     - \c tls_session, security parameter state of a single session
+ *       within a VPN tunnel.  Contains two instances of the \c key_state
+ *       structure.
+ *     - \c key_state, security parameter state of one TLS and data
+ *       channel %key set.
+ *  - Data channel security parameter containers:
+ *     - \c key_ctx_bi, container for two sets of OpenSSL cipher and/or
+ *       HMAC context (both directions).  Contains two instances of the \c
+ *       key_ctx structure.
+ *     - \c key_ctx, container for one set of OpenSSL cipher and/or HMAC
+ *       context (one directions.
+ *  - Key material containers:
+ *     - \c key2, container for two sets of cipher and/or HMAC %key
+ *       material (both directions).  Contains two instances of the \c key
+ *       structure.
+ *     - \c key, container for one set of cipher and/or HMAC %key material
+ *       (one direction).
+ *     - \c key_direction_state, ordering of %key material within the \c
+ *       key2.key array.
+ *  - Key method 2 random material containers:
+ *     - \c key_source2, container for both halves of random material used
+ *       for %key method 2.  Contains two instances of the \c key_source
+ *       structure.
+ *     - \c key_source, container for one half of random material used for
+ *       %key method 2.
+ * 
+ * @par The life of a \c tls_multi object
+ * A \c tls_multi structure contains all the security parameter state
+ * information related to the control and data channels of one VPN tunnel.
+ * Its life cycle can be summarized as follows:
+ *  -# Initialization: \c tls_multi_init() and \c
+ *     tls_multi_init_finalize(), which are called (indirectly) from \c
+ *     init_instance() when initializing a new \c context structure.
+ *     - Initializes a \c tls_multi structure.
+ *     - Allocates the three \c tls_session objects contained by the \c
+ *       tls_multi structure, and initializes as appropriate.
+ *  -# Management: \c tls_multi_process() and \c tls_pre_decrypt()
+ *     - If a new session is initiated by the remote peer, then \c
+ *       tls_pre_decrypt() starts the new session negotiation in the
+ *       un-trusted \c tls_session.
+ *     - If the, as yet, un-trusted \c tls_session authenticates
+ *       successfully, then \c tls_multi_process() moves it so as to be
+ *       the active \c tls_session.
+ *     - If an error occurs during processing of a \c key_state object,
+ *       then \c tls_multi_process() cleans up and initializes the
+ *       associated \c tls_session object.  If the error occurred in the
+ *       active \c key_state of the active \c tls_session and the
+ *       lame-duck \c key_state of that \c tls_session has not yet
+ *       expired, it is preserved as fallback.
+ *  -# Cleanup: \c tls_multi_free(), which is called (indirectly) from \c
+ *     close_instance() when cleaning up a \c context structure.
+ *     - Cleans up a \c tls_multi structure.
+ *     - Cleans up the three \c tls_session objects contained by the \c
+ *       tls_multi structure.
+ * 
+ * @par The life of a \c tls_session object
+ * A \c tls_session structure contains the state information related to an
+ * active and a lame-duck \c key_state.  Its life cycle can be summarized
+ * as follows:
+ *  -# Initialization: \c tls_session_init()
+ *     - Initializes a \c tls_session structure.
+ *     - Initializes the primary \c key_state by calling \c
+ *       key_state_init().
+ *  -# Renegotiation: \c key_state_soft_reset()
+ *     - Cleans up the old lame-duck \c key_state by calling \c
+ *       key_state_free().
+ *     - Moves the old primary \c key_state to be the new lame-duck \c
+ *       key_state.
+ *     - Initializes a new primary \c key_state by calling \c
+ *       key_state_init().
+ *  -# Cleanup: \c tls_session_free()
+ *     - Cleans up a \c tls_session structure.
+ *     - Cleans up all \c key_state objects associated with the session by
+ *       calling \c key_state_free() for each.
+ * 
+ * @par The life of a \c key_state object
+ * A \c key_state structure represents one control and data channel %key
+ * set.  It contains an OpenSSL TLS object that encapsulates the control
+ * channel, and the data channel security parameters needed by the \link
+ * data_crypto Data Channel Crypto module\endlink to perform cryptographic
+ * operations on data channel packets.  Its life cycle can be summarized
+ * as follows:
+ *  -# Initialization: \c key_state_init()
+ *     - Initializes a \c key_state structure.
+ *     - Creates a new OpenSSL TLS object to encapsulate this new control
+ *       channel session.
+ *     - Sets \c key_state.state to \c S_INITIAL.
+ *     - Allocates several internal buffers.
+ *     - Initializes new reliability layer structures for this key set.
+ *  -# Negotiation: \c tls_process()
+ *     - The OpenSSL TLS object negotiates a TLS session between itself
+ *       and the remote peer's TLS object.
+ *     - Key material is generated and exchanged through the TLS session
+ *       between OpenVPN peers.
+ *     - Both peers initialize their data channel cipher and HMAC key
+ *       contexts.
+ *     - On successful negotiation, the \c key_state.state will progress
+ *       from \c S_INITIAL to \c S_ACTIVE and \c S_NORMAL.
+ *  -# Active tunneling: \link data_crypto Data Channel Crypto
+ *     module\endlink
+ *     - Data channel packet to be sent to a remote OpenVPN peer:
+ *        - \c tls_pre_encrypt() loads the security parameters from the \c
+ *          key_state into a \c crypto_options structure.
+ *        - \c openvpn_encrypt() uses the \c crypto_options to an encrypt
+ *          and HMAC sign the data channel packet.
+ *     - Data channel packet received from a remote OpenVPN peer:
+ *        - \c tls_pre_decrypt() loads the security parameters from the \c
+ *          key_state into a \c crypto_options structure.
+ *        - \c openvpn_encrypt() uses the \c crypto_options to
+ *          authenticate and decrypt the data channel packet.
+ *  -# Cleanup: \c key_state_free()
+ *     - Cleans up a \c key_state structure together with its OpenSSL TLS
+ *       object, key material, internal buffers, and reliability layer
+ *       structures.
+ * 
+ * @par Control functions
+ * The following two functions drive the Control Channel Processor's
+ * activities.
+ *  - \c tls_multi_process(), iterates through the \c tls_session objects
+ *    within a given \c tls_multi of a VPN tunnel, and calls \c
+ *    tls_process() for each \c tls_session which is being set up, is
+ *    already active, or is busy expiring.
+ *  - \c tls_process(), performs the Control Channel Processor module's
+ *    core handling of received control channel messages, and generates
+ *    appropriate messages to be sent.
+ * 
+ * @par Functions which control data channel key generation
+ *  - Key method 1 key exchange functions:
+ *     - \c key_method_1_write(), generates and processes key material to
+ *       be sent to the remote OpenVPN peer.
+ *     - \c key_method_1_read(), processes key material received from the
+ *       remote OpenVPN peer.
+ *  - Key method 2 key exchange functions:
+ *     - \c key_method_2_write(), generates and processes key material to
+ *       be sent to the remote OpenVPN peer.
+ *     - \c key_method_2_read(), processes key material received from the
+ *       remote OpenVPN peer.
+ */
diff --git a/doc_data_control.h b/doc_data_control.h
new file mode 100644
index 0000000..cebe28e
--- /dev/null
+++ b/doc_data_control.h
@@ -0,0 +1,103 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file
+ * Data Channel Control module documentation file.
+ */
+
+/**
+ * @defgroup data_control Data Channel Control module
+ * 
+ * This module controls the processing of packets as they pass through the
+ * data channel.
+ * 
+ * The Data Channel Control module controls the processing of packets as
+ * they pass through the data channel.  The processing includes packet
+ * compression, fragmentation, and the performing of security operations
+ * on the packets.  This module does not do the processing itself, but
+ * passes the packet to other data channel modules to perform the
+ * appropriate actions.
+ * 
+ * Packets can travel in two directions through the data channel.  They
+ * can be going to a remote destination which is reachable through a VPN
+ * tunnel, in which case this module prepares them to be sent out through
+ * a VPN tunnel.  On the other hand, they can have been received through a
+ * VPN tunnel from a remote OpenVPN peer, in which case this module
+ * retrieves the packet in its original form as it was before entering the
+ * VPN tunnel on the remote OpenVPN peer.  How this module processes
+ * packets traveling in the two directions is discussed in more detail
+ * below.
+ * 
+ * @par Packets to be sent to a remote OpenVPN peer
+ * This module's main function for processing packets traveling in this
+ * direction is \c encrypt_sign(), which performs the following processing
+ * steps:
+ * - Call the \link compression Data Channel Compression module\endlink to
+ *   perform packet compression if necessary.
+ * - Call the \link fragmentation Data Channel Fragmentation
+ *   module\endlink to perform packet fragmentation if necessary.
+ * - Call the \link data_crypto Data Channel Crypto module\endlink to
+ *   perform the required security operations.
+ * 
+ * @par
+ * See the \c encrypt_sign() documentation for details of these
+ * interactions.
+ * 
+ * @par
+ * After the above processing is complete, the packet is ready to be sent
+ * to a remote OpenVPN peer as a VPN tunnel packet.  The actual sending of
+ * the packet is handled by the \link external_multiplexer External
+ * Multiplexer\endlink.
+ * 
+ * @par Packets received from a remote OpenVPN peer
+ * The function that controls how packets traveling in this direction are
+ * processed is \c process_incoming_link().  That function, however, also
+ * performs some of the tasks required for the \link external_multiplexer
+ * External Multiplexer\endlink and is therefore listed as part of that
+ * module, instead of here.
+ * 
+ * @par
+ * After the \c process_incoming_link() function has determined that a
+ * received packet is a data channel packet, it performs the following
+ * processing steps:
+ * - Call the \link data_crypto Data Channel Crypto module\endlink to
+ *   perform the required security operations.
+ * - Call the \link fragmentation Data Channel Fragmentation
+ *   module\endlink to perform packet reassembly if necessary.
+ * - Call the \link compression Data Channel Compression module\endlink to
+ *   perform packet decompression if necessary.
+ * 
+ * @par
+ * See the \c process_incoming_link() documentation for details of these
+ * interactions.
+ * 
+ * @par
+ * After the above processing is complete, the packet is in its original
+ * form again as it was received by the remote OpenVPN peer.  It can now
+ * be routed further to its final destination.  If that destination is a
+ * locally reachable host, then the \link internal_multiplexer Internal
+ * Multiplexer\endlink will send it there.
+ */
diff --git a/doc_eventloop.h b/doc_eventloop.h
new file mode 100644
index 0000000..f7e46cc
--- /dev/null
+++ b/doc_eventloop.h
@@ -0,0 +1,67 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file
+ * Main Event Loop module documentation file.
+ */
+
+/**
+ * @defgroup eventloop Main Event Loop module
+ * 
+ * This main event loop module drives the packet processing of OpenVPN.
+ * 
+ * OpenVPN is an event driven system.  Its activities are driven by a main
+ * event loop, which repeatedly waits for one of several predefined events
+ * to occur, and then calls the appropriate module to handle the event.
+ * The major types of network events that OpenVPN processes are:
+ * - A packet can be read from the external network interface.
+ *   - The main event loop activates the \link external_multiplexer
+ *     External Multiplexer\endlink to read and process the packet.
+ * - A packet can be read from the virtual tun/tap network interface.
+ *   - The main event loop activates the \link internal_multiplexer
+ *     Internal Multiplexer\endlink to read and process the packet.
+ * - If a packet is ready to be sent out as a VPN tunnel packet: the
+ *   external network interface can be written to.
+ *   - The main event loop activates the \link external_multiplexer
+ *     External Multiplexer\endlink to send the packet.
+ * - If a packet is ready to be sent to a locally reachable destination:
+ *   the virtual tun/tap network interface can be written to.
+ *   - The main event loop activates the \link internal_multiplexer
+ *     Internal Multiplexer\endlink to send the packet.
+ * 
+ * Beside these external events, OpenVPN also processes other types of
+ * internal events.  These include scheduled events, such as resending of
+ * non-acknowledged control channel messages.
+ * 
+ * @par Main event loop implementations
+ * 
+ * Depending on the mode in which OpenVPN is running, a different main
+ * event loop function is called to drive the event processing.  The
+ * following implementations are available:
+ * - Client mode using UDP or TCP: \c tunnel_point_to_point()
+ * - Server mode using UDP: \c tunnel_server_udp_single_threaded()
+ * - Server mode using TCP: \c tunnel_server_tcp()
+ */
diff --git a/doc_external_multiplexer.h b/doc_external_multiplexer.h
new file mode 100644
index 0000000..f78f648
--- /dev/null
+++ b/doc_external_multiplexer.h
@@ -0,0 +1,46 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file
+ * External Multiplexer module documentation file.
+ */
+
+/**
+ * @addtogroup external_multiplexer External Multiplexer module
+ * 
+ * The External Multiplexer is the link between the external network
+ * interface and the other OpenVPN modules.  It reads packets from the
+ * external network interface, determines which remote OpenVPN peer and
+ * VPN tunnel they are associated with, and whether they are data channel
+ * or control channel packets.  It then passes the packets on to the
+ * appropriate processing module.
+ * 
+ * This module also handles packets traveling in the reverse direction,
+ * which have been generated by the local control channel or which have
+ * already been processed by the \link data_control Data Channel Control
+ * module\endlink and are destined for a remote host reachable through a
+ * VPN tunnel.
+ */
diff --git a/doc_internal_multiplexer.h b/doc_internal_multiplexer.h
new file mode 100644
index 0000000..cdaf4a2
--- /dev/null
+++ b/doc_internal_multiplexer.h
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file
+ * Internal Multiplexer module documentation file.
+ */
+
+/**
+ * @addtogroup internal_multiplexer Internal Multiplexer module
+ * 
+ * The Internal Multiplexer is the link between the virtual tun/tap
+ * network interface and the \link data_control Data Channel Control
+ * module\endlink.  It reads packets from the virtual network interface,
+ * determines for which remote OpenVPN peer they are destined, and then
+ * passes the packets on to the Data Channel Control module together with
+ * information about their destination VPN tunnel instance.
+ * 
+ * This module also handles packets traveling in the reverse direction,
+ * which have already been processed by the Data Channel Control module
+ * and are destined for a locally reachable host.
+ */
diff --git a/doc_mainpage.h b/doc_mainpage.h
new file mode 100644
index 0000000..ade5f5b
--- /dev/null
+++ b/doc_mainpage.h
@@ -0,0 +1,162 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file
+ * Main page documentation file.
+ */
+
+/**
+ * @mainpage OpenVPN v2.1 source code documentation
+ * 
+ * This documentation describes the internal structure of OpenVPN.  It was
+ * automatically generated from specially formatted comment blocks in
+ * OpenVPN's source code using Doxygen.  (See
+ * http://www.stack.nl/~dimitri/doxygen/ for more information on Doxygen)
+ * 
+ * The \ref mainpage_modules "Modules section" below gives an introduction
+ * into the high-level module concepts used throughout this documentation.
+ * The \ref mainpage_relatedpages "Related Pages section" below describes
+ * various special subjects related to OpenVPN's implementation which are
+ * discussed in the related pages section.
+ * 
+ * @section mainpage_modules Modules
+ * 
+ * For the purpose of describing the internal structure of OpenVPN, this
+ * documentation and the underlying source code has been broken up into a
+ * number of conceptually well-defined parts, known as modules. Each
+ * module plays a specific role within the OpenVPN process, and in most
+ * cases each module has a clear interfacing strategy for interacting with
+ * other modules.
+ * 
+ * The following modules have been defined:
+ * - Driver module:
+ *   - The \link eventloop Main Event Loop\endlink: this module drives the
+ *     event handling of OpenVPN.  It implements various types of
+ *     select-loop which wait until an event happens, and then delegate
+ *     the handling of that event to the appropriate module.
+ * - Network interface modules:
+ *   - The \link external_multiplexer External Multiplexer\endlink: this
+ *     module sends and receives packets to and from remote OpenVPN peers
+ *     over the external network interface.  It also takes care of
+ *     demultiplexing received packets to their appropriate VPN tunnel and
+ *     splitting control channel and data channel packets.
+ *   - The \link internal_multiplexer Internal Multiplexer\endlink: this
+ *     module sends and receives packets to and from locally reachable
+ *     posts over the virtual tun/tap network interface.  It also takes
+ *     care of determining through which VPN tunnel a received packet must
+ *     be sent to reach its destination.
+ * - Control channel modules:
+ *   - The \link reliable Reliability Layer\endlink: this module offers a
+ *     %reliable and sequential transport layer for control channel
+ *     messages.
+ *   - The \link control_tls Control Channel TLS module\endlink: this
+ *     module offers a secure encapsulation of control channel messages
+ *     using the TLS protocol.
+ *   - The \link control_processor Control Channel Processor\endlink: his
+ *     module manages the setup, maintenance, and shut down of VPN
+ *     tunnels.
+ * - Data channel modules:
+ *   - The \link data_control Data Channel Control module\endlink: this
+ *     module controls the processing of data channel packets and,
+ *     depending on the settings of the packet's VPN tunnel, passes the
+ *     packet to the three modules below for handling.
+ *   - The \link data_crypto Data Channel Crypto module\endlink: this
+ *     module performs security operations on data channel packets.
+ *   - The \link fragmentation Data Channel Fragmentation module\endlink:
+ *     this module offers fragmentation of data channel packets larger
+ *     than the VPN tunnel's MTU.
+ *   - The \link compression Data Channel Compression module\endlink: this
+ *     module offers compression of data channel packets.
+ * 
+ * @subsection mainpage_modules_example Example event: receiving a packet
+ * 
+ * OpenVPN handles many types of events during operation.  These include
+ * external events, such as network traffic being received, and internal
+ * events, such as a %key session timing out causing renegotiation.  An
+ * example event, receiving a packet over the network, is described here
+ * together with which modules play what roles:
+ * -# The \link eventloop Main Event Loop\endlink detects that a packet
+ *    can be read from the external or the virtual tun/tap network
+ *    interface.
+ * -# The \link eventloop Main Event Loop\endlink calls the \link
+ *    external_multiplexer External Multiplexer\endlink or \link
+ *    internal_multiplexer Internal Multiplexer\endlink to read and
+ *    process the packet.
+ * -# The multiplexer module determines the type of packet and its
+ *    destination, and passes the packet on to the appropriate handling
+ *    module:
+ *    - A control channel packet received by the \link
+ *      external_multiplexer External Multiplexer\endlink is passed on
+ *      through the \link reliable Reliability Layer\endlink and the \link
+ *      control_tls Control Channel TLS module\endlink to the \link
+ *      control_processor Control Channel Processor\endlink.
+ *    - A data channel packet received by either multiplexer module is
+ *      passed on to the \link data_control Data Channel Control
+ *      module\endlink.
+ * -# The packet is processed by the appropriate control channel or data
+ *    channel modules.
+ * -# If, after processing the packet, a resulting packet is generated
+ *    that needs to be sent to a local or remote destination, it is given
+ *    to the \link external_multiplexer External Multiplexer\endlink or
+ *    \link internal_multiplexer Internal Multiplexer\endlink for sending.
+ * -# If a packet is waiting to be sent by either multiplexer module and
+ *    the \link eventloop Main Event Loop\endlink detects that data can be
+ *    written to the associated network interface, it calls the
+ *    multiplexer module to send the packet.
+ * 
+ * @section mainpage_relatedpages Related pages
+ * 
+ * This documentation includes a number of descriptions of various aspects
+ * of OpenVPN and its implementation.  These are not directly related to
+ * one module, function, or data structure, and are therefore listed
+ * separately under "Related Pages".
+ * 
+ * @subsection mainpage_relatedpages_key_generation Data channel key generation
+ * 
+ * The @ref key_generation "Data channel key generation" related page
+ * describes how, during VPN tunnel setup and renegotiation, OpenVPN peers
+ * generate and exchange the %key material required for the symmetric
+ * encryption/decryption and HMAC signing/verifying security operations
+ * performed on data channel packets.
+ * 
+ * @subsection mainpage_relatedpages_tunnel_state VPN tunnel state
+ * 
+ * The @ref tunnel_state "Structure of VPN tunnel state storage" related
+ * page describes how an OpenVPN process manages the state information
+ * associated with its active VPN tunnels.
+ * 
+ * @subsection mainpage_relatedpages_network_protocol Network protocol
+ * 
+ * The @ref network_protocol "Network protocol" related page describes the
+ * format and content of VPN tunnel packets exchanged between OpenVPN
+ * peers.
+ * 
+ * @subsection mainpage_relatedpages_memory_management Memory management
+ * 
+ * The @ref memory_management "Memory management strategies" related page
+ * gives a brief introduction into OpenVPN's memory %buffer library and
+ * garbage collection facilities.
+ */
diff --git a/doc_protocol_overview.h b/doc_protocol_overview.h
new file mode 100644
index 0000000..de844e7
--- /dev/null
+++ b/doc_protocol_overview.h
@@ -0,0 +1,199 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Network protocol overview documentation file.
+ */
+
+/**
+ * @page network_protocol OpenVPN's network protocol
+ * 
+ * Description of packet structure in OpenVPN's network protocol.
+ * 
+ * This document describes the structure of packets exchanged between
+ * OpenVPN peers.  It is based on the protocol description in the \c ssl.h
+ * file.
+ * 
+ * @section network_protocol_external Outer structure of packets exchanged between OpenVPN peers
+ * 
+ * VPN tunnel packets are transported between OpenVPN peers using the UDP
+ * or TCP protocols.  Their structure is described below.
+ * 
+ * @subsection network_protocol_external_structure External packet structure
+ * 
+ *  - packet length (16 bits, unsigned) [TCP-mode only]: always sent as
+ *    plain text.  Since TCP is a stream protocol, this packet length
+ *    defines the packetization of the stream.
+ *  - packet opcode and key_id (8 bits) [TLS-mode only]:
+ *     - package message type (high 5 bits)
+ *     - key_id (low 3 bits): the key_id refers to an already negotiated
+ *       TLS session.  OpenVPN seamlessly renegotiates the TLS session by
+ *       using a new key_id for the new session.  Overlap (controlled by
+ *       user definable parameters) between old and new TLS sessions is
+ *       allowed, providing a seamless transition during tunnel operation.
+ *  - payload (n bytes)
+ * 
+ * @subsection network_protocol_external_types Message types
+ * 
+ * The type of a VPN tunnel packet is indicated by its opcode.  The
+ * following describes the various opcodes available.
+ * 
+ *  - Control channel messages:
+ *     - \c P_CONTROL_HARD_RESET_CLIENT_V1 -- %Key method 1, initial %key
+ *       from client, forget previous state.
+ *     - \c P_CONTROL_HARD_RESET_SERVER_V1 -- %Key method 1, initial %key
+ *       from server, forget previous state.
+ *     - \c P_CONTROL_HARD_RESET_CLIENT_V2 -- %Key method 2, initial %key
+ *       from client, forget previous state.
+ *     - \c P_CONTROL_HARD_RESET_SERVER_V2 -- %Key method 2, initial %key
+ *       from server, forget previous state.
+ *     - \c P_CONTROL_SOFT_RESET_V1 -- New %key, with a graceful
+ *       transition from old to new %key in the sense that a transition
+ *       window exists where both the old or new key_id can be used.
+ *     - \c P_CONTROL_V1 -- Control channel packet (usually TLS
+ *       ciphertext).
+ *     - \c P_ACK_V1 -- Acknowledgement for control channel packets
+ *       received.
+ *  - Data channel messages:
+ *     - \c P_DATA_V1 -- Data channel packet containing data channel
+ *       ciphertext.
+ * 
+ * @subsection network_protocol_external_key_id Session IDs and Key IDs
+ * 
+ * OpenVPN uses two different forms of packet identifiers:
+ *  - The first form is 64 bits and is used for all control channel
+ *    messages.  This form is referred to as a \c session_id.
+ *  - Data channel messages on the other hand use a shortened form of 3
+ *    bits for efficiency reasons since the vast majority of OpenVPN
+ *    packets in an active tunnel will be data channel messages.  This
+ *    form is referred to as a \c key_id.
+ * 
+ * The control and data channels use independent packet-id sequences,
+ * because the data channel is an unreliable channel while the control
+ * channel is a %reliable channel.  Each use their own independent HMAC
+ * keys.
+ * 
+ * @subsection network_protocol_external_reliable Control channel reliability layer
+ * 
+ * Control channel messages (\c P_CONTROL_* and \c P_ACK_* message types)
+ * are TLS ciphertext packets which have been encapsulated inside of a
+ * reliability layer.  The reliability layer is implemented as a
+ * straightforward acknowledge and retransmit model.
+ * 
+ * Acknowledgments of received messages can be encoded in either the
+ * dedicated \c P_ACK_* record or they can be prepended to a \c
+ * P_CONTROL_* message.
+ * 
+ * See the \link reliable Reliability Layer\endlink module for a detailed
+ * description.
+ * 
+ * @section network_protocol_control Structure of control channel messages
+ * 
+ * @subsection network_protocol_control_ciphertext Structure of ciphertext control channel messages
+ * 
+ * Control channel packets in ciphertext form consist of the following
+ * parts:
+ * 
+ *  - local \c session_id (random 64 bit value to identify TLS session).
+ *  - HMAC signature of entire encapsulation header for HMAC firewall
+ *    [only if \c --tls-auth is specified] (usually 16 or 20 bytes).
+ *  - packet-id for replay protection (4 or 8 bytes, includes sequence
+ *    number and optional \c time_t timestamp).
+ *  - acknowledgment packet-id array length (1 byte).
+ *  - acknowledgment packet-id array (if length > 0).
+ *  - acknowledgment remote session-id (if length > 0).
+ *  - packet-id of this message (4 bytes).
+ *  - TLS payload ciphertext (n bytes) (only for \c P_CONTROL_V1).
+ * 
+ * Note that when \c --tls-auth is used, all message types are protected
+ * with an HMAC signature, even the initial packets of the TLS handshake.
+ * This makes it easy for OpenVPN to throw away bogus packets quickly,
+ * without wasting resources on attempting a TLS handshake which will
+ * ultimately fail.
+ * 
+ * @subsection network_protocol_control_key_methods Control channel key methods and
+ * 
+ * Once the TLS session has been initialized and authenticated, the TLS
+ * channel is used to exchange random %key material for bidirectional
+ * cipher and HMAC keys which will be used to secure data channel packets.
+ * OpenVPN currently implements two %key methods.  %Key method 1 directly
+ * derives keys using random bits obtained from the \c RAND_bytes()
+ * OpenSSL function.  %Key method 2 mixes random %key material from both
+ * sides of the connection using the TLS PRF mixing function.  %Key method
+ * 2 is the preferred method and is the default for OpenVPN 2.0.
+ * 
+ * The @ref key_generation "Data channel key generation" related page
+ * describes the %key methods in more detail.
+ * 
+ * @subsection network_protocol_control_plaintext Structure of plaintext control channel messages
+ * 
+ *  - %Key method 1:
+ *     - Cipher %key length in bytes (1 byte).
+ *     - Cipher %key (n bytes).
+ *     - HMAC %key length in bytes (1 byte).
+ *     - HMAC %key (n bytes).
+ *     - %Options string (n bytes, null terminated, client/server %options
+ *       string should match).
+ *  - %Key method 2:
+ *     - Literal 0 (4 bytes).
+ *     - %Key method (1 byte).
+ *     - \c key_source structure (\c key_source.pre_master only defined
+ *       for client -> server).
+ *     - %Options string length, including null (2 bytes).
+ *     - %Options string (n bytes, null terminated, client/server %options
+ *       string must match).
+ *     - [The username/password data below is optional, record can end at
+ *       this point.]
+ *     - Username string length, including null (2 bytes).
+ *     - Username string (n bytes, null terminated).
+ *     - Password string length, including null (2 bytes).
+ *     - Password string (n bytes, null terminated).
+ * 
+ * @section network_protocol_data Structure of data channel messages
+ * 
+ * @subsection network_protocol_data_ciphertext Structure of ciphertext data channel messages
+ * 
+ * The P_DATA_* payload represents encrypted, encapsulated tunnel packets
+ * which tend to be either IP packets or Ethernet frames. This is
+ * essentially the "payload" of the VPN.
+ * 
+ * Data channel packets in ciphertext form consist of the following parts:
+ *  - HMAC of ciphertext IV + ciphertext (if not disabled by \c --auth
+ *    none).
+ *  - Ciphertext IV (size is cipher-dependent, if not disabled by \c
+ *    --no-iv).
+ *  - Tunnel packet ciphertext.
+ * 
+ * @subsection network_protocol_data_plaintext Structure of plaintext data channel messages
+ * 
+ * Data channel packets in plaintext form consist of the following parts:
+ *  - packet-id (4 or 8 bytes, if not disabled by --no-replay).
+ *     - In TLS mode, 4 bytes are used because the implementation can
+ *       force a TLS renegotation before \c 2^32 packets are sent.
+ *     - In pre-shared %key mode, 8 bytes are used (sequence number and \c
+ *       time_t value) to allow long-term %key usage without packet-id
+ *       collisions.
+ *  - User plaintext (n bytes).
+ */
diff --git a/doc_tunnel_state.h b/doc_tunnel_state.h
new file mode 100644
index 0000000..7a24a0f
--- /dev/null
+++ b/doc_tunnel_state.h
@@ -0,0 +1,155 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file
+ * VPN tunnel state documentation file.
+ */
+
+/**
+ * @page tunnel_state Structure of the VPN tunnel state storage
+ * 
+ * This section describes how OpenVPN stores its VPN tunnel state during
+ * operation.
+ * 
+ * OpenVPN uses several data structures as storage containers for state
+ * information of active VPN tunnels.  These are described in this
+ * section, together with a little bit of history to help understand the
+ * origin of the current architecture.
+ * 
+ * Whether an OpenVPN process is running in client-mode or server-mode
+ * determines whether it can support only one or multiple simultaneously
+ * active VPN tunnels.  This consequently also determines how the
+ * associated state information is wrapped up internally.  This section
+ * gives an overview of the differences.
+ * 
+ * @section tunnel_state_history Historic developments
+ * 
+ * In the old v1.x series, an OpenVPN process managed only one single VPN
+ * tunnel.  This allowed the VPN tunnel state to be stored together with
+ * process-global information in one single \c context structure.
+ * 
+ * This changed, however, in the v2.x series, as new OpenVPN versions
+ * running in server-mode can support multiple simultaneously active VPN
+ * tunnels.  This necessitated a redesign of the VPN tunnel state
+ * container structures, and modification of the \link
+ * external_multiplexer External Multiplexer\endlink and \link
+ * internal_multiplexer Internal Multiplexer\endlink systems.  The
+ * majority of these changes are only relevant for OpenVPN processes
+ * running in server-mode, and the client-mode structure has remained very
+ * similar to the v1.x single-tunnel form.
+ * 
+ * @section tunnel_state_client Client-mode state
+ * 
+ * An OpenVPN process running in client-mode can manage at most one single
+ * VPN tunnel at any one time.  The state information for a client's VPN
+ * tunnel is stored in a \c context structure.
+ * 
+ * The \c context structure is created in the \c main() function.  That is
+ * also where process-wide initialization takes place, such as parsing
+ * command line %options and reading configuration files.  The \c context
+ * is then passed to \c tunnel_point_to_point() which drives OpenVPN's
+ * main event processing loop.  These functions are both part of the \link
+ * eventloop Main Event Loop\endlink module.
+ * 
+ * @subsection tunnel_state_client_init Initialization and cleanup
+ * 
+ * Because there is only one \c context structure present, it can be
+ * initialized and cleaned up from the client's main event processing
+ * function.  Before the \c tunnel_point_to_point() function enters its
+ * event loop, it calls \c init_instance_handle_signals() which calls \c
+ * init_instance() to initialize the single \c context structure.  After
+ * the event loop stops, it calls \c close_instance() to clean up the \c
+ * context.
+ * 
+ * @subsection tunnel_state_client_event Event processing
+ * 
+ * When the main event processing loop activates the external or internal
+ * multiplexer to handle a network event, it is not necessary to determine
+ * which VPN tunnel the event is associated with, because there is only
+ * one VPN tunnel active.
+ * 
+ * @section tunnel_state_server Server-mode state
+ * 
+ * An OpenVPN process running in server-mode can manage multiple
+ * simultaneously active VPN tunnels.  For every VPN tunnel active, in
+ * other words for every OpenVPN client which is connected to a server,
+ * the OpenVPN server has one \c context structure in which it stores that
+ * particular VPN tunnel's state information.
+ * 
+ * @subsection tunnel_state_server_multi Multi_context and multi_instance structures
+ * 
+ * To support multiple \c context structures, each is wrapped in a \c
+ * multi_instance structure, and all the \c multi_instance structures are
+ * registered in one single \c multi_context structure.  The \link
+ * external_multiplexer External Multiplexer\endlink and \link
+ * internal_multiplexer Internal Multiplexer\endlink then use the \c
+ * multi_context to retrieve the correct \c multi_instance and \c context
+ * associated with a given network address.
+ * 
+ * @subsection tunnel_state_server_init Startup and initialization
+ * 
+ * An OpenVPN process running in server-mode starts in the same \c main()
+ * function as it would in client-mode.  The same process-wide
+ * initialization is performed, and the resulting state and configuration
+ * is stored in a \c context structure. The server-mode and client-mode
+ * processes diverge when the \c main() function calls one of \c
+ * tunnel_point_to_point() or \c tunnel_server().
+ * 
+ * In server-mode, \c main() calls the \c tunnel_server() function, which
+ * transfers control to \c tunnel_server_udp_single_threaded() or \c
+ * tunnel_server_tcp() depending on the external transport protocol.
+ * 
+ * These functions receive the \c context created in \c main().  This
+ * object has a special status in server-mode, as it does not represent an
+ * active VPN tunnel, but does contain process-wide configuration
+ * parameters.  In the source code, it is often stored in "top" variables.
+ * To distinguish this object from other instances of the same type, its
+ * \c context.mode value is set to \c CM_TOP.  Other \c context objects,
+ * which do represent active VPN tunnels, have a \c context.mode set to \c
+ * CM_CHILD_UDP or \c CM_CHILD_TCP, depending on the external transport
+ * protocol.
+ * 
+ * Both \c tunnel_server_udp_single_threaded() and \c tunnel_server_tcp()
+ * perform similar initialization.  In either case, a \c multi_context
+ * structure is created, and it is initialized according to the
+ * configuration stored in the top \c context by the \c multi_init() and
+ * \c multi_top_init() functions.
+ * 
+ * @subsection tunnel_state_server_tunnels Creating and destroying VPN tunnels
+ * 
+ * When an OpenVPN client makes a new connection to a server, the server
+ * creates a new \c context and \c multi_instance.  The latter is
+ * registered in the \c multi_context, which makes it possible for the
+ * external and internal multiplexers to retrieve the correct \c
+ * multi_instance and \c context when a network event occurs.
+ * 
+ * @subsection tunnel_state_server_cleanup Final cleanup
+ * 
+ * After the main event loop exits, both \c
+ * tunnel_server_udp_single_threaded() and \c tunnel_server_tcp() perform
+ * similar cleanup.  They call \c multi_uninit() followed by \c
+ * multi_top_free() to clean up the \c multi_context structure.
+ */
diff --git a/forward.h b/forward.h
index 76d8b9e..fac2e00 100644
--- a/forward.h
+++ b/forward.h
@@ -22,6 +22,13 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+
+/**
+ * @file
+ * Interface functions to the internal and external multiplexers.
+ */
+
+
 #ifndef FORWARD_H
 #define FORWARD_H
 
@@ -54,22 +61,170 @@
 
 #define IOW_READ            (IOW_READ_TUN|IOW_READ_LINK)
 
-void pre_select (struct context *c);
 
+void pre_select (struct context *c);
 void process_io (struct context *c);
 
-void encrypt_sign (struct context *c, bool comp_frag);
-
 const char *wait_status_string (struct context *c, struct gc_arena *gc);
 void show_wait_status (struct context *c);
 
+
+/**********************************************************************/
+/**
+ * Process a data channel packet that will be sent through a VPN tunnel.
+ * @ingroup data_control
+ * 
+ * This function controls the processing of a data channel packet which
+ * will be sent through a VPN tunnel to a remote OpenVPN peer.  It's
+ * general structure is as follows:
+ * - Check that the client authentication has succeeded; if not, drop the
+ *   packet.
+ * - If the \a comp_frag argument is true:
+ *   - Call \c lzo_compress() of the \link Data Channel Compression
+ *     module\endlink to (possibly) compress the packet.
+ *   - Call \c fragment_outgoing() of the \link Data Channel Fragmentation
+ *     module\endlink to (possibly) fragment the packet.
+ * - Activate the \link Data Channel Crypto module\endlink to perform
+ *   security operations on the packet.
+ *   - Call \c tls_pre_encrypt() to choose the appropriate security
+ *     parameters for this packet.
+ *   - Call \c openvpn_encrypt() to encrypt and HMAC signed the packet.
+ *   - Call \c tls_post_encrypt() to prepend the one-byte OpenVPN header
+ *     and do some TLS accounting.
+ * - Place the resulting packet in \c c->c2.to_link so that it can be sent
+ *   over the external network interface to its remote destination by the
+ *   \link external_multiplexer External Multiplexer\endlink.
+ * 
+ * @param c - The context structure of the VPN tunnel associated with this
+ *     packet.
+ * @param comp_frag - Whether to do packet compression and fragmentation.
+ *     This flag is set to true the first time a packet is processed.  If
+ *     the packet then gets fragmented, this function will be called again
+ *     once for each remaining fragment with this parameter set to false.
+ */
+void encrypt_sign (struct context *c, bool comp_frag);
+
+
+/**********************************************************************/
+/**
+ * Read a packet from the external network interface.
+ * @ingroup external_multiplexer
+ * 
+ * The packet read from the external network interface is stored in \c
+ * c->c2.buf and its source address in \c c->c2.from.  If an error
+ * occurred, the length of \c c->c2.buf will be 0.
+ * 
+ * OpenVPN running as client or as UDP server only has a single external
+ * network socket, so this function can be called with the single (client
+ * mode) or top level (UDP server) context as its argument. OpenVPN
+ * running as TCP server, on the other hand, has a network socket for each
+ * active VPN tunnel.  In that case this function must be called with the
+ * context associated with the appropriate VPN tunnel for which data is
+ * available to be read.
+ * 
+ * @param c - The context structure which contains the external
+ *     network socket from which to read incoming packets.
+ */
 void read_incoming_link (struct context *c);
+
+
+/**
+ * Process a packet read from the external network interface.
+ * @ingroup external_multiplexer
+ * 
+ * This function controls the processing of a data channel packet which
+ * has come out of a VPN tunnel.  It's high-level structure is as follows:
+ * - Verify that a nonzero length packet has been received from a valid
+ *   source address for the given context \a c.
+ * - Call \c tls_pre_decrypt(), which splits data channel and control
+ *   channel packets:
+ *   - If a data channel packet, the appropriate security parameters are
+ *     loaded.
+ *   - If a control channel packet, this function process is it and
+ *     afterwards sets the packet's buffer length to 0, so that the data
+ *     channel processing steps below will ignore it.
+ * - Call \c openvpn_decrypt() of the \link data_crypto Data Channel
+ *   Crypto module\endlink to authenticate and decrypt the packet using
+ *   the security parameters loaded by \c tls_pre_decrypt() above.
+ * - Call \c fragment_incoming() of the \link fragmentation Data Channel
+ *   Fragmentation module\endlink to reassemble the packet if it's
+ *   fragmented.
+ * - Call \c lzo_decompress() of the \link compression Data Channel
+ *   Compression module\endlink to decompress the packet if it's
+ *   compressed.
+ * - Place the resulting packet in \c c->c2.to_tun so that it can be sent
+ *   over the virtual tun/tap network interface to its local destination
+ *   by the \link internal_multiplexer Internal Multiplexer\endlink.
+ * 
+ * @param c - The context structure of the VPN tunnel associated with the
+ *     packet.
+ */
 void process_incoming_link (struct context *c);
+
+
+/**
+ * Write a packet to the external network interface.
+ * @ingroup external_multiplexer
+ * 
+ * This function writes the packet stored in \c c->c2.to_link to the
+ * external network device contained within \c c->c1.link_socket.
+ * 
+ * If an error occurs, it is logged and the packet is dropped.
+ * 
+ * @param c - The context structure of the VPN tunnel associated with the
+ *     packet.
+ */
+void process_outgoing_link (struct context *c);
+
+
+/**************************************************************************/
+/**
+ * Read a packet from the virtual tun/tap network interface.
+ * @ingroup internal_multiplexer
+ * 
+ * This function reads a packet from the virtual tun/tap network device \c
+ * c->c1.tuntap and stores it in \c c->c2.buf.
+ * 
+ * If an error occurs, it is logged and the packet is dropped.
+ * 
+ * @param c - The context structure in which to store the received
+ *     packet.
+ */
 void read_incoming_tun (struct context *c);
+
+
+/**
+ * Process a packet read from the virtual tun/tap network interface.
+ * @ingroup internal_multiplexer
+ * 
+ * This function calls \c encrypt_sign() of the \link data_control Data
+ * Channel Control module\endlink to process the packet.
+ * 
+ * If an error occurs, it is logged and the packet is dropped.
+ * 
+ * @param c - The context structure of the VPN tunnel associated with the
+ *     packet.
+ */
 void process_incoming_tun (struct context *c);
-void process_outgoing_link (struct context *c);
+
+
+/**
+ * Write a packet to the virtual tun/tap network interface.
+ * @ingroup internal_multiplexer
+ * 
+ * This function writes the packet stored in \c c->c2.to_tun to the
+ * virtual tun/tap network device \c c->c1.tuntap.
+ * 
+ * If an error occurs, it is logged and the packet is dropped.
+ * 
+ * @param c - The context structure of the VPN tunnel associated with
+ *     the packet.
+ */
 void process_outgoing_tun (struct context *c);
 
+
+/**************************************************************************/
+
 bool send_control_channel_string (struct context *c, const char *str, int msglevel);
 
 #define PIPV4_PASSTOS         (1<<0)
diff --git a/mtcp.h b/mtcp.h
index 3585af4..0b5308d 100644
--- a/mtcp.h
+++ b/mtcp.h
@@ -60,8 +60,17 @@ void multi_tcp_instance_specific_free (struct multi_instance *mi);
 
 void multi_tcp_link_out_deferred (struct multi_context *m, struct multi_instance *mi);
 
+
+/**************************************************************************/
+/**
+ * Main event loop for OpenVPN in TCP server mode.
+ * @ingroup eventloop
+ * 
+ * @param top - Top-level context structure.
+ */
 void tunnel_server_tcp (struct context *top);
 
+
 void multi_tcp_delete_event (struct multi_tcp *mtcp, event_t event);
 
 #endif
diff --git a/mtu.h b/mtu.h
index d9fa020..e47fd58 100644
--- a/mtu.h
+++ b/mtu.h
@@ -86,39 +86,43 @@
  */
 #define PAYLOAD_ALIGN 4
 
-struct frame {
-  /*
-   * Maximum datagram size to be sent over the tunnel TCP/UDP channel.
-   */
-  int link_mtu;
-  int link_mtu_dynamic;
-
-  /*
-   * How many extra bytes might each subsystem (crypto, TLS, or, compression)
-   * add to frame in worst case?
-   *
-   * mtu + extra_frame = MTU of TCP/UDP transport
-   */
-  int extra_frame;
-
-  /*
-   * Worst case size added to internal buffer due to functions
-   * such as compression which can potentially expand the size of uncompressible
-   * data.
-   */
-  int extra_buffer;
-
-  /*
-   * Max number of bytes in excess of tun mtu size that we might read
-   * or write from TUN/TAP device.
-   */
-  int extra_tun;
 
-  /*
-   * Max number of bytes in excess of link mtu size that we might read
-   * or write from UDP/TCP link.
-   */
-  int extra_link;
+/**************************************************************************/
+/**
+ * Packet geometry parameters.
+ */
+struct frame {
+  int link_mtu;                 /**< Maximum packet size to be sent over
+                                 *   the external network interface. */
+
+  int link_mtu_dynamic;         /**< Dynamic MTU value for the external
+                                 *   network interface. */
+
+  int extra_frame;              /**< Maximum number of bytes that all
+                                 *   processing steps together could add.
+                                 *   @code
+                                 *   frame.link_mtu = "socket MTU" - extra_frame;
+                                 *   @endcode
+                                 */
+
+  int extra_buffer;             /**< Maximum number of bytes that
+                                 *   processing steps could expand the
+                                 *   internal work buffer.
+                                 *   
+                                 *   This is used by the \link compression
+                                 *   Data Channel Compression
+                                 *   module\endlink to give enough working
+                                 *   space for worst-case expansion of
+                                 *   incompressible content. */
+
+  int extra_tun;                /**< Maximum number of bytes in excess of
+                                 *   the tun/tap MTU that might be read
+                                 *   from or written to the virtual
+                                 *   tun/tap network interface. */
+
+  int extra_link;               /**< Maximum number of bytes in excess of
+                                 *   external network interface's MTU that
+                                 *   might be read from or written to it. */
 
   /*
    * Alignment control
diff --git a/mudp.c b/mudp.c
index a478b29..1e17299 100644
--- a/mudp.c
+++ b/mudp.c
@@ -199,9 +199,17 @@ p2mp_iow_flags (const struct multi_context *m)
   return flags;
 }
 
-/*
- * Top level event loop for single-threaded operation.
- * UDP mode.
+
+/**************************************************************************/
+/**
+ * Main event loop for OpenVPN in UDP server mode.
+ * @ingroup eventloop
+ * 
+ * This function implements OpenVPN's main event loop for UDP server mode.
+ *  At this time, OpenVPN does not yet support multithreading.  This
+ * function's name is therefore slightly misleading.
+ * 
+ * @param top - Top-level context structure.
  */
 static void
 tunnel_server_udp_single_threaded (struct context *top)
diff --git a/mudp.h b/mudp.h
index dc9cfde..5d347fa 100644
--- a/mudp.h
+++ b/mudp.h
@@ -34,8 +34,37 @@
 struct context;
 struct multi_context;
 
+
+/**************************************************************************/
+/**
+ * Main event loop wrapper function for OpenVPN in UDP server mode.
+ * @ingroup eventloop
+ * 
+ * This function simply calls \c tunnel_server_udp_single_threaded().
+ * 
+ * @param top          - Top-level context structure.
+ */
 void tunnel_server_udp (struct context *top);
 
+
+/**************************************************************************/
+/**
+ * Get, and if necessary create, the multi_instance associated with a
+ * packet's source address.
+ * @ingroup external_multiplexer
+ * 
+ * This function extracts the source address of a recently read packet
+ * from \c m->top.c2.from and uses that source address as a hash key for
+ * the hash table \c m->hash.  If an entry exists, this function returns
+ * it.  If no entry exists, this function handles its creation, and if
+ * successful, returns the newly created instance.
+ * 
+ * @param m            - The single multi_context structure.
+ * 
+ * @return A pointer to a multi_instance if one already existed for the
+ *     packet's source address or if one was a newly created successfully.
+ *      NULL if one did not yet exist and a new one was not created.
+ */
 struct multi_instance *multi_get_create_instance_udp (struct multi_context *m);
 
 #endif
diff --git a/multi.h b/multi.h
index 08964a2..f5925c7 100644
--- a/multi.h
+++ b/multi.h
@@ -22,6 +22,10 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+/**
+ * @file Header file for server-mode related structures and functions.
+ */
+
 #ifndef MULTI_H
 #define MULTI_H
 
@@ -50,8 +54,16 @@ struct multi_reap
   time_t last_call;
 };
 
-/*
- * One multi_instance object per client instance.
+
+/**
+ * Server-mode state structure for one single VPN tunnel.
+ * 
+ * This structure is used by OpenVPN processes running in server-mode to
+ * store state information related to one single VPN tunnel.
+ * 
+ * The @ref tunnel_state "Structure of VPN tunnel state storage" related
+ * page describes the role the structure plays when OpenVPN is running in
+ * server-mode.
  */
 struct multi_instance {
   struct schedule_entry se;    /* this must be the first element of the structure */
@@ -60,9 +72,13 @@ struct multi_instance {
   bool halt;
   int refcount;
   int route_count;             /* number of routes (including cached routes) owned by this instance */
-  time_t created;
+  time_t created;               /**< Time at which a VPN tunnel instance
+                                 *   was created.  This parameter is set
+                                 *   by the \c multi_create_instance()
+                                 *   function. */
   struct timeval wakeup;       /* absolute time */
-  struct mroute_addr real;
+  struct mroute_addr real;      /**< External network address of the
+                                 *   remote peer. */
   ifconfig_pool_handle vaddr_handle;
   const char *msg_prefix;
 
@@ -84,11 +100,20 @@ struct multi_instance {
   bool did_iroutes;
   int n_clients_delta; /* added to multi_context.n_clients when instance is closed */
 
-  struct context context;
+  struct context context;       /**< The context structure storing state
+                                 *   for this VPN tunnel. */
 };
 
-/*
- * One multi_context object per server daemon thread.
+
+/**
+ * Main OpenVPN server state structure.
+ *
+ * This structure is used by OpenVPN processes running in server-mode to
+ * store all the VPN tunnel and process-wide state.
+ *
+ * The @ref tunnel_state "Structure of VPN tunnel state storage" related
+ * page describes the role the structure plays when OpenVPN is running in
+ * server-mode.
  */
 struct multi_context {
 # define MC_UNDEF                      0
@@ -99,12 +124,19 @@ struct multi_context {
 # define MC_WORK_THREAD                (MC_MULTI_THREADED_WORKER|MC_MULTI_THREADED_SCHEDULER)
   int thread_mode;
 
-  struct hash *hash;   /* client instances indexed by real address */
-  struct hash *vhash;  /* client instances indexed by virtual address */
-  struct hash *iter;   /* like real address hash but optimized for iteration */
+  struct hash *hash;            /**< VPN tunnel instances indexed by real
+                                 *   address of the remote peer. */
+  struct hash *vhash;           /**< VPN tunnel instances indexed by
+                                 *   virtual address of remote hosts. */
+  struct hash *iter;            /**< VPN tunnel instances indexed by real
+                                 *   address of the remote peer, optimized
+                                 *   for iteration. */
   struct schedule *schedule;
-  struct mbuf_set *mbuf;
-  struct multi_tcp *mtcp;
+  struct mbuf_set *mbuf;        /**< Set of buffers for passing data
+                                 *   channel packets between VPN tunnel
+                                 *   instances. */
+  struct multi_tcp *mtcp;       /**< State specific to OpenVPN using TCP
+                                 *   as external transport. */
   struct ifconfig_pool *ifconfig_pool;
   struct frequency_limit *new_connection_limiter;
   struct mroute_helper *route_helper;
@@ -127,7 +159,8 @@ struct multi_context {
   struct context_buffers *context_buffers;
   time_t per_second_trigger;
 
-  struct context top;
+  struct context top;           /**< Storage structure for process-wide
+                                 *   configuration. */
 };
 
 /*
@@ -146,11 +179,22 @@ struct multi_route
   time_t last_reference;
 };
 
-/*
- * top level function, called by openvpn.c
+
+/**************************************************************************/
+/**
+ * Main event loop for OpenVPN in server mode.
+ * @ingroup eventloop
+ * 
+ * This function calls the appropriate main event loop function depending
+ * on the transport protocol used:
+ *  - \c tunnel_server_udp()
+ *  - \c tunnel_server_tcp()
+ * 
+ * @param top          - Top-level context structure.
  */
 void tunnel_server (struct context *top);
 
+
 const char *multi_instance_string (const struct multi_instance *mi, bool null, struct gc_arena *gc);
 
 /*
@@ -172,11 +216,77 @@ bool multi_process_timeout (struct multi_context *m, const unsigned int mpp_flag
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
 #define MPP_CLOSE_ON_SIGNAL        (1<<2)
 #define MPP_RECORD_TOUCH           (1<<3)
+
+
+/**************************************************************************/
+/**
+ * Perform postprocessing of a VPN tunnel instance.
+ * 
+ * After some VPN tunnel activity has taken place, the VPN tunnel's state
+ * may need updating and some follow-up action may be required.  This
+ * function controls the necessary postprocessing.  It is called by many
+ * other functions that handle VPN tunnel related activity, such as \c
+ * multi_process_incoming_link(), \c multi_process_outgoing_link(), \c
+ * multi_process_incoming_tun(), \c multi_process_outgoing_tun(), and \c
+ * multi_process_timeout(), among others.
+ * 
+ * @param m            - The single \c multi_context structure.
+ * @param mi           - The \c multi_instance of the VPN tunnel to be
+ *                       postprocessed.
+ * @param flags        - Fast I/O optimization flags.
+ * 
+ * @return
+ *  - True, if the VPN tunnel instance \a mi was not closed due to a
+ *    signal during processing.
+ *  - False, if the VPN tunnel instance \a mi was closed.
+ */
 bool multi_process_post (struct multi_context *m, struct multi_instance *mi, const unsigned int flags);
 
+
+/**************************************************************************/
+/**
+ * Demultiplex and process a packet received over the external network
+ * interface.
+ * @ingroup external_multiplexer
+ * 
+ * This function determines which VPN tunnel instance the incoming packet
+ * is associated with, and then calls \c process_incoming_link() to handle
+ * it.  Afterwards, if the packet is destined for a broadcast/multicast
+ * address or a remote host reachable through a different VPN tunnel, this
+ * function takes care of sending it they are.
+ * 
+ * @note This function is only used by OpenVPN processes which are running
+ *     in server mode, and can therefore sustain multiple active VPN
+ *     tunnels.
+ * 
+ * @param m            - The single \c multi_context structure.
+ * @param instance     - The VPN tunnel state structure associated with
+ *                       the incoming packet, if known, as is the case
+ *                       when using TCP transport. Otherwise NULL, as is
+ *                       the case when using UDP transport.
+ * @param mpp_flags    - Fast I/O optimization flags.
+ */
 bool multi_process_incoming_link (struct multi_context *m, struct multi_instance *instance, const unsigned int mpp_flags);
+
+
+/**
+ * Determine the destination VPN tunnel of a packet received over the
+ * virtual tun/tap network interface and then process it accordingly.
+ * @ingroup internal_multiplexer
+ * 
+ * This function determines which VPN tunnel instance the packet is
+ * destined for, and then calls \c process_outgoing_tun() to handle it.
+ * 
+ * @note This function is only used by OpenVPN processes which are running
+ *     in server mode, and can therefore sustain multiple active VPN
+ *     tunnels.
+ * 
+ * @param m            - The single \c multi_context structure.
+ * @param mpp_flags    - Fast I/O optimization flags.
+ */
 bool multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flags);
 
+
 void multi_process_drop_outgoing_tun (struct multi_context *m, const unsigned int mpp_flags);
 
 void multi_print_status (struct multi_context *m, struct status_output *so, const int version);
@@ -397,8 +507,23 @@ multi_get_timeout (struct multi_context *m, struct timeval *dest)
     }
 }
 
-/*
- * Send a packet to TUN/TAP interface.
+
+/**
+ * Send a packet over the virtual tun/tap network interface to its locally
+ * reachable destination.
+ * @ingroup internal_multiplexer
+ * 
+ * This function calls \c process_outgoing_tun() to perform the actual
+ * sending of the packet.  Afterwards, it calls \c multi_process_post() to
+ * perform server-mode postprocessing.
+ * 
+ * @param m            - The single \c multi_context structure.
+ * @param mpp_flags    - Fast I/O optimization flags.
+ * 
+ * @return
+ *  - True, if the \c multi_instance associated with the packet sent was
+ *    not closed due to a signal during processing.
+ *  - Falls, if the \c multi_instance was closed.
  */
 static inline bool
 multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flags)
@@ -419,6 +544,8 @@ multi_process_outgoing_tun (struct multi_context *m, const unsigned int mpp_flag
   return ret;
 }
 
+
+
 static inline bool
 multi_process_outgoing_link_dowork (struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
diff --git a/openvpn.c b/openvpn.c
index 99b343b..faf2858 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -42,6 +42,16 @@ process_signal_p2p (struct context *c)
   return process_signal (c);
 }
 
+
+
+/**************************************************************************/
+/**
+ * Main event loop for OpenVPN in client mode, where only one VPN tunnel
+ * is active.
+ * @ingroup eventloop
+ * 
+ * @param c - The context structure of the single active VPN tunnel.
+ */
 static void
 tunnel_point_to_point (struct context *c)
 {
@@ -90,6 +100,27 @@ tunnel_point_to_point (struct context *c)
 
 #undef PROCESS_SIGNAL_P2P
 
+
+/**************************************************************************/
+/**
+ * OpenVPN's main init-run-cleanup loop.
+ * @ingroup eventloop
+ * 
+ * This function contains the two outer OpenVPN loops.  Its structure is
+ * as follows:
+ *  - Once-per-process initialization.
+ *  - Outer loop, run at startup and then once per \c SIGHUP:
+ *    - Level 1 initialization
+ *    - Inner loop, run at startup and then once per \c SIGUSR1:
+ *      - Call event loop function depending on client or server mode:
+ *        - \c tunnel_point_to_point()
+ *        - \c tunnel_server()
+ *    - Level 1 cleanup
+ *  - Once-per-process cleanup.
+ * 
+ * @param argc - Commandline argument count.
+ * @param argv - Commandline argument values.
+ */
 int
 main (int argc, char *argv[])
 {
diff --git a/openvpn.h b/openvpn.h
index 33661df..81ca109 100644
--- a/openvpn.h
+++ b/openvpn.h
@@ -126,10 +126,14 @@ struct context_persist
   int restart_sleep_seconds;
 };
 
-/* 
- * level 0 context contains data related to
- * once-per OpenVPN instantiation events
- * such as daemonization.
+
+/**************************************************************************/
+/**
+ * Level 0 %context containing information related to the OpenVPN process.
+ * 
+ * Level 0 state is initialized once at program startup, and then remains
+ * throughout the lifetime of the OpenVPN process.  This structure
+ * contains information related to the process's PID, user, and group.
  */
 struct context_0
 {
@@ -143,14 +147,21 @@ struct context_0
   struct group_state group_state;
 };
 
-/*
- * Contains the persist-across-restart OpenVPN tunnel instance state.
- * Reset only for SIGHUP restarts.
+
+/**
+ * Level 1 %context containing state that persists across \c SIGUSR1
+ * restarts.
+ * 
+ * Level 1 state is reset on \c SIGHUP restarts.  This structure is
+ * initialized for every iteration of the \c main() function's outer \c
+ * SIGHUP loop, but persists over iteration of that function's inner \c
+ * SIGUSR1 loop.
  */
 struct context_1
 {
-  /* local and remote addresses */
   struct link_socket_addr link_socket_addr;
+                                /**< Local and remote addresses on the
+                                 *   external network. */
 
   /* tunnel session keys */
   struct key_schedule ks;
@@ -158,12 +169,14 @@ struct context_1
   /* persist crypto sequence number to/from file */
   struct packet_id_persist pid_persist;
 
-  /* TUN/TAP interface */
-  struct tuntap *tuntap;
-  bool tuntap_owned;
+  struct tuntap *tuntap;        /**< Tun/tap virtual network interface. */
+  bool tuntap_owned;            /**< Whether the tun/tap interface should
+                                 *   be cleaned up when this %context is
+                                 *   cleaned up. */
 
-  /* list of --route directives */
   struct route_list *route_list;
+                                /**< List of routing information. See the
+                                 *   \c --route command line option. */
 
   /* list of --route-ipv6 directives */
   struct route_ipv6_list *route_ipv6_list;
@@ -194,20 +207,30 @@ struct context_1
 
   /* if client mode, hash of option strings we pulled from server */
   struct md5_digest pulled_options_digest_save;
+                                /**< Hash of option strings received from the
+                                 *   remote OpenVPN server.  Only used in
+                                 *   client-mode. */
 
-  /* save user/pass for authentication */
   struct user_pass *auth_user_pass;
+                                /**< Username and password for
+                                 *   authentication. */
 #endif
 };
 
-/*
- * Contains the OpenVPN tunnel instance state, wiped across
- * SIGUSR1 and SIGHUP restarts.
+/**
+ * Level 2 %context containing state that is reset on both \c SIGHUP and
+ * \c SIGUSR1 restarts.
+ *
+ * This structure is initialized at the top of the \c
+ * tunnel_point_to_point(), \c tunnel_server_udp_single_threaded(), and \c
+ * tunnel_server_tcp() functions.  In other words, it is reset for every
+ * iteration of the \c main() function's inner \c SIGUSR1 loop.
  */
 struct context_2
 {
-  /* garbage collection arena for context_2 scope */
-  struct gc_arena gc;
+  struct gc_arena gc;           /**< Garbage collection arena for
+                                 *   allocations done in the level 2 scope
+                                 *   of this context_2 structure. */
 
   /* our global wait events */
   struct event_set *event_set;
@@ -315,12 +338,19 @@ struct context_2
    */
 #ifdef USE_SSL
 
-  /* master OpenVPN SSL/TLS object */
-  struct tls_multi *tls_multi;
+  struct tls_multi *tls_multi;  /**< TLS state structure for this VPN
+                                 *   tunnel. */
 
-  /* check --tls-auth signature without needing
-     a full-size tls_multi object */
   struct tls_auth_standalone *tls_auth_standalone;
+                                /**< TLS state structure required for the
+                                 *   initial authentication of a client's
+                                 *   connection attempt.  This structure
+                                 *   is used by the \c
+                                 *   tls_pre_decrypt_lite() function when
+                                 *   it performs the HMAC firewall check
+                                 *   on the first connection packet
+                                 *   received from a new client.  See the
+                                 *   \c --tls-auth commandline option. */
 
   /* used to optimize calls to tls_multi_process */
   struct interval tmp_int;
@@ -330,10 +360,11 @@ struct context_2
 
 #endif /* USE_SSL */
 
-  /* passed to encrypt or decrypt, contains all
-     crypto-related command line options related
-     to data channel encryption/decryption */
   struct crypto_options crypto_options;
+                                /**< Security parameters and crypto state
+                                 *   used by the \link data_crypto Data
+                                 *   Channel Crypto module\endlink to
+                                 *   process data channel packet. */
 
   /* used to keep track of data channel packet sequence numbers */
   struct packet_id packet_id;
@@ -341,11 +372,11 @@ struct context_2
 
 #endif /* USE_CRYPTO */
 
-  /*
-   * LZO compression library workspace.
-   */
 #ifdef USE_LZO
   struct lzo_compress_workspace lzo_compwork;
+                                /**< Compression workspace used by the
+                                 *   \link compression Data Channel
+                                 *   Compression module\endlink. */
 #endif
 
   /*
@@ -462,16 +493,25 @@ struct context_2
 #endif
 };
 
-/*
+
+/**
  * Contains all state information for one tunnel.
+ * 
+ * This structure represents one VPN tunnel.  It is used to store state
+ * information related to a VPN tunnel, but also includes process-wide
+ * data, such as configuration options.
+ * 
+ * The @ref tunnel_state "Structure of VPN tunnel state storage" related
+ * page describes how this structure is used in client-mode and
+ * server-mode.
  */
 struct context
 {
-  /* command line or config file options */
-  struct options options;
+  struct options options;       /**< Options loaded from command line or
+                                 *   configuration file. */
 
-  /* true on initial VPN iteration */
-  bool first_time;
+  bool first_time;              /**< True on the first iteration of
+                                 *   OpenVPN's main loop. */
 
   /* context modes */
 # define CM_P2P            0 /* standalone point-to-point session or client */
@@ -479,41 +519,32 @@ struct context
 # define CM_TOP_CLONE      2 /* clone of a CM_TOP context for one thread */
 # define CM_CHILD_UDP      3 /* child context of a CM_TOP or CM_THREAD */
 # define CM_CHILD_TCP      4 /* child context of a CM_TOP or CM_THREAD */
-  int mode;
+  int mode;                     /**< Role of this context within the
+                                 *   OpenVPN process.  Valid values are \c
+                                 *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
+                                 *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP. */
 
-  /* garbage collection for context scope
-     allocations */
-  struct gc_arena gc;
+  struct gc_arena gc;           /**< Garbage collection arena for
+                                 *   allocations done in the scope of this
+                                 *   context structure. */
 
-  /* environmental variable settings */
-  struct env_set *es;
+  struct env_set *es;           /**< Set of environment variables. */
 
-  /* signal info */
-  struct signal_info *sig;
+  struct signal_info *sig;      /**< Internal error signaling object. */
 
-  /* shared object plugins */
-  struct plugin_list *plugins;
-  bool plugins_owned;
+  struct plugin_list *plugins;  /**< List of plug-ins. */
+  bool plugins_owned;           /**< Whether the plug-ins should be
+                                 *   cleaned up when this %context is
+                                 *   cleaned up. */
   
-  /* set to true after we daemonize */
-  bool did_we_daemonize;
+  bool did_we_daemonize;        /**< Whether demonization has already
+                                 *   taken place. */
 
-  /* persistent across SIGHUP */
   struct context_persist persist;
-
-  /* level 0 context contains data related to
-     once-per OpenVPN instantiation events
-     such as daemonization */
-  struct context_0 *c0;
-
-  /* level 1 context is preserved for
-     SIGUSR1 restarts, but initialized
-     for SIGHUP restarts */
-  struct context_1 c1;
-
-  /* level 2 context is initialized for all
-     restarts (SIGUSR1 and SIGHUP) */
-  struct context_2 c2;
+                                /**< Persistent %context. */
+  struct context_0 *c0;         /**< Level 0 %context. */
+  struct context_1 c1;          /**< Level 1 %context. */
+  struct context_2 c2;          /**< Level 2 %context. */
 };
 
 /*
-- 
1.7.4.1


